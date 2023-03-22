import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/helpers/errors.dart';
import 'package:provider_example/models/jokes_categories_response.dart';
import 'package:provider_example/provider/jokes_categories.dart';

class JokesListingWidget extends StatefulWidget {
  const JokesListingWidget({super.key});

  @override
  State<JokesListingWidget> createState() => _JokesListingWidgetState();
}

class _JokesListingWidgetState extends State<JokesListingWidget> {
  late JokesCategoriesResponse _jokesCategoriesResponse;
  @override
  void initState() {
    _jokesCategoriesResponse =
        Provider.of<JokesCategoriesProvider>(context, listen: false)
            .jokesCategories!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_jokesCategoriesResponse.categories != null) {
      return _jokesCategoriesResponse.categories!.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: Text(_jokesCategoriesResponse.categories![index]),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(_jokesCategoriesResponse
                            .categories![index]
                            .toString()))),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _jokesCategoriesResponse.categories!.length,
            )
          : const Text('No Jokes Categories found');
    } else {
      return const ErrorsWidget(
        errorMessage: 'Unable to fetch the jokes',
      );
    }
  }
}
