class JokesCategoriesResponse {
  List<String>? categories = List.empty();

  JokesCategoriesResponse({this.categories});

  JokesCategoriesResponse.fromJson(List<dynamic>? json) {
    categories = json == null ? null : List<String>.from(json);
  }

  List<dynamic> toJson() {
    List<dynamic> data = List<dynamic>.empty();
    if (categories != null) {
      data = categories as List<dynamic>;
    }
    return data;
  }
}
