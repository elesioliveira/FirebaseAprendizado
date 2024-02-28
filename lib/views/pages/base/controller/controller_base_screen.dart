import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  limparSearchTitle() {
    searchController.text = '';
  }

  set searchTitle(String value) {
    if (searchController.text != value) {
      searchController.text = value;
      notifyListeners();
    }
  }
}
