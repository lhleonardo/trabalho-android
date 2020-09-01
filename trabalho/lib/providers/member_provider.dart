import 'package:flutter/material.dart';
import 'package:trabalho/models/house.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/services/member.dart';

class MemberProvider extends ChangeNotifier {
  Member _loggedMember;
  House _loggedMemberHouse;

  final MemberService _memberService = MemberService();
  final HouseService _houseService = HouseService();

  Future<void> setLoggedMemberFor(String firebaseUserId) async {
    setLoggedMember(await _memberService.getById(firebaseUserId));
  }

  void logout() {
    _loggedMember = null;
    _loggedMemberHouse = null;

    notifyListeners();
  }

  Future<void> setMemberHouse(String houseId) async {
    _loggedMemberHouse = await _houseService.getById(houseId);

    notifyListeners();
  }

  Member get loggedMember {
    return _loggedMember;
  }

  Future<void> setLoggedMember(Member member) async {
    _loggedMember = member;

    if (_loggedMember.houseId != null && _loggedMember.houseId.isNotEmpty) {
      _loggedMemberHouse = await _houseService.getById(_loggedMember.houseId);
    }

    notifyListeners();
  }

  void setInfo(Member member, House house) {
    _loggedMember = member;
    _loggedMemberHouse = house;

    notifyListeners();
  }

  House get loggedMemberHouse {
    return _loggedMemberHouse;
  }
}
