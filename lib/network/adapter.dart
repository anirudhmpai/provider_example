import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider_example/network/api_constants.dart';

import 'endpoints.dart';
import 'exceptions.dart';

enum RequestType {
  delete,
  get,
  patch,
  post,
  put,
}

enum FormRequestType {
  raw,
  formData,
}

class NetworkAdapter {
  static final NetworkAdapter shared = NetworkAdapter._privateConstructor();
  NetworkAdapter._privateConstructor();

  Future<dynamic> send({
    EndPoint? endPoint,
    Map<String, dynamic>? params,
    String? id,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    var client = http.Client();
    Map<String, String>? headers = {
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (endPoint?.shouldAddToken == true) {
      headers = {
        "Accept": "application/json",
        "content-type": "application/json",
        // 'Authorization': 'Bearer ${await SecureStorageHelper.shared.getToken()}'
      };
    } else {
      headers = {};
    }

    if (params != null) {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        params["platform"] = Platform.isAndroid ? "android" : "ios";
      } else if (defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows) {
        // Some desktop specific code there
      } else {
        // Some web specific code there
      }
    }
    http.Response response;
    String url = "";
    if (id != null) {
      url = endPoint!.cleanUrlWith(id);
    } else {
      url = endPoint!.url;
    }

    try {
      var uri = Uri.https(ApiConstants.baseUrl, url, params ?? {});
      switch (endPoint.requestType) {
        case RequestType.delete:
          response = await client.delete(uri, headers: headers);
          break;
        case RequestType.get:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.patch:
          response = await client.patch(uri, headers: headers);
          break;
        case RequestType.post:
          response = await client.post(uri, headers: headers);
          break;
        case RequestType.put:
          response = await client.put(uri, headers: headers);
          break;
      }
    } on SocketException catch (exception) {
      return 'ERROR:${exception.message}'; // If response is available.
    }
    return checkAndReturnResponse(response);
  }

  dynamic checkAndReturnResponse(http.Response response) {
    String? description; // App specific handling!
    Map<String, dynamic> jsonResponse = {};
    try {
      jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return response.body;
    }
    description =
        jsonResponse.containsKey('message') ? jsonResponse['message'] : null;
    switch (response.statusCode) {
      case 200:
      case 201:
        // Null check for response.data
        if (jsonResponse.isEmpty) {
          throw FetchDataException(
              'Returned response data is null : ${response.reasonPhrase}');
        }
        return jsonResponse;
      case 400:
        throw BadRequestException(description ?? response.reasonPhrase);
      case 401:
      case 403:
        throw UnauthorizedException(description ?? response.reasonPhrase);
      case 404:
        throw NotFoundException(description ?? response.reasonPhrase);
      case 500:
        throw InternalServerException(description ?? response.reasonPhrase);
      default:
        throw FetchDataException(
            "Unknown error occurred\n\nerror Code: ${response.statusCode}  error: ${response.reasonPhrase}");
    }
  }
}
