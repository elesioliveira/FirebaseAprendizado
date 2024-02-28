import 'package:flutter/material.dart';

abstract class NavigationTabs {
  static const int firstPage = 0;
  static const int secondPage = 1;
  static const int treePage = 2;
}

class PageviewController with ChangeNotifier {
  late PageController _pageController;
  int _value = 0;

  PageController get pageController => _pageController;
  int get currentIndex => _value;

  void incrementarValor() {
    if (_value == 2) return;

    _value++;
    notifyListeners();
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  // Construtor para realizar a inicialização
  PageviewController() {
    initNavigation(
      pageController: PageController(initialPage: NavigationTabs.firstPage),
      currentIndex: NavigationTabs.firstPage,
    );
  }

  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _value = currentIndex;
    notifyListeners();
  }

  void navigatePageView(int page) {
    if (_value == page) return;

    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    _value = page;
    notifyListeners();
  }
}
