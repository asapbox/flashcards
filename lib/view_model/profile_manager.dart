import 'package:flutter/material.dart';

class ProfileManager extends ChangeNotifier {
  bool isDarkMode = true;

  void setDarkMode(bool isActive) {
    isDarkMode = isActive;
    notifyListeners();
  }
}