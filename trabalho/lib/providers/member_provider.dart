import 'package:flutter/material.dart';
import 'package:trabalho/models/member.dart';

class MemberProvider extends ChangeNotifier {
  Member _currentMember;

  Member getCurrentMember() {
    return _currentMember;
  }

  void setCurrentMember(Member value) {
    _currentMember = value;

    notifyListeners();
  }
}
