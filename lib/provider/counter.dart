import 'package:flutter/material.dart';
import 'package:provider_example/provider/base.dart';

class CounterProvider extends BaseProvider {
  int counterValue;
  BuildContext context;

  CounterProvider(
    this.context,
    this.counterValue,
  ) {
    initData();
  }

  void initData() {
    debugPrint('Initial Value $counterValue');
  }

  void incrementCounter() {
    counterValue++;
    debugPrint('Counter Incremented Value $counterValue');
    notifyListeners();
  }

  decrementCounter() {
    counterValue--;
    debugPrint('Counter Decremented Value $counterValue');
    notifyListeners();
  }

  resetCounter() {
    counterValue = 0;
    debugPrint('Counter Reset Value $counterValue');
    notifyListeners();
  }
}
