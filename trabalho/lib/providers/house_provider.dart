import 'package:flutter/material.dart';
import 'package:trabalho/models/house.dart';

class HouseProvider extends ChangeNotifier {
  House _currentHouse;

  House getCurrentHouse() {
    return _currentHouse;
  }

  void setCurrentHouse(House value) {
    _currentHouse = value;

    notifyListeners();
  }
}
