import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/models/house.dart';
import 'package:trabalho/services/member.dart';

class HouseService {
  final _collection = FirebaseFirestore.instance.collection('houses');
  final _memberService = MemberService();

  Future<House> getById(String id) async {
    final snapshot = await _collection.doc(id).get();
    return snapshot != null ? House.fromMap(snapshot.data(), id) : null;
  }

  Future<House> create(
    String name,
    String address,
    String state,
    String city,
    String managerId,
  ) async {
    final reference = await _collection.add(
      {
        'name': name,
        'address': address,
        'state': state,
        'city': city,
        'members': [
          {'member_id': managerId, 'is_manager': true},
        ]
      },
    );

    await _memberService.setHouse(managerId, reference.id);

    return House(
      name: name,
      address: address,
      state: state,
      city: city,
    );
  }
}
