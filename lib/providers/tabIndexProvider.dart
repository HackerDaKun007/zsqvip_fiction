import 'package:flutter/material.dart';

class TabIndexProvider extends ChangeNotifier {
  int tabCurrentIndex;

  TabIndexProvider() {
    tabCurrentIndex = 0;
  }

  changeCurrentIndex(index) {
    tabCurrentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}