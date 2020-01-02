import 'package:flutter/material.dart';

class CounterProvide with ChangeNotifier {
  int value = 0;

  increment() {
    value++;
    notifyListeners();
  }
}
