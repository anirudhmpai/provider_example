import 'dart:convert';

import 'package:provider_example/models/jokes_categories_response.dart';
import 'package:provider_example/network/adapter.dart';
import 'package:provider_example/network/endpoints.dart';
import 'package:provider_example/provider/base.dart';

class JokesCategoriesProvider extends BaseProvider {
  JokesCategoriesResponse? jokesCategories;

  Future<JokesCategoriesResponse> fetchJokesCategories() async {
    var response = await NetworkAdapter.shared
        .send(endPoint: EndPoint.jokesCategories, params: {});
    if (response.contains('ERROR')) {
      jokesCategories = JokesCategoriesResponse.fromJson([]);
    } else {
      jokesCategories = JokesCategoriesResponse.fromJson(json.decode(response));
    }
    return jokesCategories!;
  }
}
