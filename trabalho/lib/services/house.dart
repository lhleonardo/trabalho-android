import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/models/house.dart';
import 'package:trabalho/services/member.dart';

class HouseService {
  final _collection = FirebaseFirestore.instance.collection('houses');
  final _memberService = MemberService();

  Future<House> getById(String id) async {
    final snapshot = await _collection.doc(id).get();
    return snapshot != null && snapshot.exists
        ? House.fromMap(snapshot.data(), id)
        : null;
  }

  Future<House> create({
    String name,
    String address,
    String state,
    String city,
    String managerId,
  }) async {
    final reference = await _collection.add(
      {
        'name': name,
        'address': address,
        'state': state,
        'city': city,
      },
    );

    await reference
        .collection('members')
        .add({'member_id': managerId, 'is_manager': true});

    await _memberService.setHouse(
      memberId: managerId,
      houseId: reference.id,
    );

    return House(
      name: name,
      address: address,
      state: state,
      city: city,
    );
  }

  Future<bool> checkExists({String houseId}) async {
    final snapshot = await _collection.doc(houseId).get();
    return snapshot.exists;
  }

  Future<void> addMember({
    String houseId,
    String memberId,
    bool isManager = false,
  }) async {
    await _collection.doc(houseId).collection('members').add(
      {
        'member_id': memberId,
        'is_manager': isManager,
      },
    );

    _memberService.setHouse(houseId: houseId, memberId: memberId);
  }

  Future<void> promoveToManager(String memberId, String houseId) async {
    final members = await _collection
        .doc(houseId)
        .collection('members')
        .where('member_id', isEqualTo: memberId)
        .get();

    // só pode ter uma associação com member_id dentro de uma república
    if (members.docs.isNotEmpty && members.docs.length == 1) {
      // define que o membro é um representante
      await _collection
          .doc(houseId)
          .collection('members')
          .doc(members.docs.first.id)
          .update({'is_manager': true});
    }
    // SE ENTRAR AQUI É PQ ESSE MEMBRO NÃO EXISTIA NO BANCO...
  }

  Future<bool> checkIsManager(String houseId, String memberId) async {
    final members = await _collection
        .doc(houseId)
        .collection('members')
        .where('member_id', isEqualTo: memberId)
        .get();

    return members.docs.any((member) {
      return member.get('is_manager') as bool;
    });
  }
}
