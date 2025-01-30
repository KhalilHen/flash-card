import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  LinearGradient currentGradient;

  ThemeProvider(this.currentGradient);

  LinearGradient get gradient => currentGradient;

  void updateTheme(LinearGradient newGradient) {
    currentGradient = newGradient;
    notifyListeners();
  }
}
