import 'package:flutter/material.dart';

class ErrorsWidget extends StatelessWidget {
  final String? errorMessage;

  final Function()? onRetryPressed;

  const ErrorsWidget({super.key, this.errorMessage, this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage ?? 'Error',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetryPressed ?? () {},
            child: const Text('Retry', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
