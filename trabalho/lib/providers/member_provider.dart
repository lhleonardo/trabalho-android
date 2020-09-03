import 'package:flutter/material.dart';
import 'package:trabalho/models/house.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/services/member.dart';

class MemberProvider extends ChangeNotifier {
  Member _loggedMember;
  House _loggedMemberHouse;

  bool _isManager;

  final MemberService _memberService = MemberService();
  final HouseService _houseService = HouseService();

  Future<void> setLoggedMemberFor(String firebaseUserId) async {
    setLoggedMember(await _memberService.getById(firebaseUserId));
  }

  void logout() {
    _loggedMember = null;
    _loggedMemberHouse = null;
    _isManager = false;

    notifyListeners();
  }

  Future<void> setMemberHouse(String houseId) async {
    _loggedMemberHouse = await _houseService.getById(houseId);
    await _checkIsManager();

    notifyListeners();
  }

  Future<void> _checkIsManager() async {
    if (_loggedMemberHouse != null) {
      _isManager = await _houseService.checkIsManager(
          _loggedMemberHouse.id, _loggedMember.id);
    } else {
      _isManager = false;
    }
  }

  Member get loggedMember {
    return _loggedMember;
  }

  Future<void> setLoggedMember(Member member) async {
    _loggedMember = member;

    if (_loggedMember.houseId != null && _loggedMember.houseId.isNotEmpty) {
      _loggedMemberHouse = await _houseService.getById(_loggedMember.houseId);
    }
    await _checkIsManager();

    notifyListeners();
  }

  Future<void> setInfo(Member member, House house) async {
    _loggedMember = member;
    _loggedMemberHouse = house;

    await _checkIsManager();
    notifyListeners();
  }

  House get loggedMemberHouse {
    return _loggedMemberHouse;
  }

  bool get isManager {
    return _isManager;
  }
}
