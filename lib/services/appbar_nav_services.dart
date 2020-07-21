import 'package:flutter/material.dart';

class AppbarNavService with ChangeNotifier {
  PageController _pageController = PageController();

  PageController get pageController => _pageController;

  int _currentIndexNav = 0;
  int get currentIndexNav => _currentIndexNav;

  set currentIndexNav(int i) {
    _currentIndexNav = i;
    if (_pageController.hasClients) {
      _pageController.animateToPage(i,
          duration: Duration(milliseconds: 400), curve: Curves.decelerate);
    }
    notifyListeners();
  }
}
