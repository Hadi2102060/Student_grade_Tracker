// lib/providers/app_state_provider.dart

import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  int _currentIndex = 0;

  bool get isDarkMode => _isDarkMode;
  int get currentIndex => _currentIndex;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
