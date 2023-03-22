import 'adapter.dart';
import 'api_constants.dart';

enum EndPoint {
  appConfig,
  jokesCategories,
}

extension URLExtension on EndPoint {
  String get url {
    switch (this) {
      case EndPoint.appConfig:
        return ApiConstants.appConfig;
      case EndPoint.jokesCategories:
        return ApiConstants.jokesCategories;
    }
  }

  /// this method is used to replace | with id
  String cleanUrlWith(String id) {
    return url.replaceAll("|", id);
  }
}

extension RequestMode on EndPoint {
  RequestType get requestType {
    RequestType requestType = RequestType.get;

    switch (this) {
      case EndPoint.appConfig:
      case EndPoint.jokesCategories:
        break;
    }
    return requestType;
  }
}

extension Token on EndPoint {
  bool get shouldAddToken {
    var shouldAdd = true;
    switch (this) {
      case EndPoint.appConfig:
      case EndPoint.jokesCategories:
        shouldAdd = false;
        break;
      default:
    }
    return shouldAdd;
  }
}

extension FormType on EndPoint {
  FormRequestType get formType {
    FormRequestType formType = FormRequestType.raw;
    switch (this) {
      case EndPoint.appConfig:
      case EndPoint.jokesCategories:
        formType = FormRequestType.formData;
        break;
    }
    return formType;
  }
}
