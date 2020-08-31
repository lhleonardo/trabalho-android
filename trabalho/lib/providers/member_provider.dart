import 'package:trabalho/models/house.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/services/member.dart';

class MemberProvider {
  Member _member;
  House _house;

  final _memberService = MemberService();
  final _houseService = HouseService();

  MemberProvider(String memberId) {
    _loadMember(memberId);
  }

  Future<void> _loadMember(String id) async {
    _member = await _memberService.getById(id);

    if (_member != null && _member.houseId != null) {
      _house = await _houseService.getById(_member.houseId);
    }
  }

  House get house {
    return _house;
  }
}
