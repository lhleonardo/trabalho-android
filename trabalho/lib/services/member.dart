import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/models/member.dart';

class MemberService {
  final _collection = FirebaseFirestore.instance.collection('users');

  Future<Member> getById(String id) async {
    final DocumentSnapshot document = await _collection.doc(id).get();

    if (document.exists) {
      return Member.fromMap(document.data(), id);
    } else {
      return null;
    }
  }

  Future<void> setHouse(String memberId, String houseId) async {
    await _collection.doc(memberId).update({'house_id': houseId});
  }
}
