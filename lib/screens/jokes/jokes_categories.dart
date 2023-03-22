import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/helpers/commons.dart';
import 'package:provider_example/helpers/errors.dart';
import 'package:provider_example/models/jokes_categories_response.dart';
import 'package:provider_example/provider/jokes_categories.dart';
import 'package:provider_example/screens/jokes/jokes_components.dart';

class JokesCategoriesScreen extends StatelessWidget {
  const JokesCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jokes Categories'),
          centerTitle: true,
        ),
        body: jokesBodyContent(context),
      ),
    );
  }

  jokesBodyContent(BuildContext context) {
    return Center(
      child: FutureBuilder<JokesCategoriesResponse>(
        future: Provider.of<JokesCategoriesProvider>(context, listen: false)
            .fetchJokesCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text(
                'Fetch Jokes Categories data',
                textAlign: TextAlign.center,
              );
            case ConnectionState.active:
              return const Text('');
            case ConnectionState.waiting:
              return Commons.loadingWidget("Fetching Jokes Categories...");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return ErrorsWidget(
                  errorMessage: "Error retrieving jokes categories.",
                  onRetryPressed: () => Provider.of<JokesCategoriesProvider>(
                          context,
                          listen: false)
                      .fetchJokesCategories(),
                );
              } else {
                return const JokesListingWidget();
              }
          }
        },
      ),
    );
  }
}
