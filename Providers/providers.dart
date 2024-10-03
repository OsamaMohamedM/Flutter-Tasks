import 'package:flutter/material.dart';

class ChangeTheme with ChangeNotifier
{
  bool _isBlue = false;

  bool get isBlue => _isBlue;
  void toggleTheme(value) {
    _isBlue =value;
    notifyListeners();
  }

}