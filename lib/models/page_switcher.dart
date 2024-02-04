import 'package:flutter/material.dart';

class PageSwitcher extends ChangeNotifier {
  int selectedTab = 0;

  void goToReleaseNotes() {
    selectedTab = 0;
    notifyListeners();
  }

  void goToBranching() {
    selectedTab = 1;
    notifyListeners();
  }
}