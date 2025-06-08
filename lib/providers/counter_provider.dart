import 'package:flutter/material.dart';

// This class holds the count value and lets the app know when it changes
class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // tells the app UI to rebuild
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

