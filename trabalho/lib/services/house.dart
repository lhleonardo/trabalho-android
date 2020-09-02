import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/models/house.dart';
import 'package:trabalho/models/member.dart';
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
    String createdAt,
  }) async {
    final reference = await _collection.add(
      {
        'name': name,
        'address': address,
        'state': state,
        'city': city,
        'created_at': createdAt,
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

  Stream<List<Member>> getManagers(String houseId) {
    return _collection
        .doc(houseId)
        .collection('members')
        .where('is_manager', isEqualTo: true)
        .snapshots()
        .map(_convertToListOfManagers);
  }

  Stream<List<Member>> getMembers(
      {String houseId, bool excludeManagers = false}) {
    final membersCollection = _collection.doc(houseId).collection('members');

    if (excludeManagers) {
      return membersCollection
          .where('is_manager', isEqualTo: false)
          .snapshots()
          .map(_convertToListOfManagers);
    } else {
      return membersCollection.snapshots().map(_convertToListOfManagers);
    }
  }

  Future<List<Member>> getCommomMembers(String houseId) async {
    final snapshot = await _collection.doc(houseId).collection('members').get();

    final List<Member> membersRelation = snapshot.docs
        .map((e) => Member.fromMap(e.data(), e.get('member_id') as String))
        .toList();

    final List<Member> result = [];

    for (int i = 0; i < membersRelation.length; i++) {
      result.add(await _memberService.getById(membersRelation[i].id));
    }

    return result;
  }

  List<Member> _convertToListOfManagers(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (member) =>
              Member.fromMap(member.data(), member.get('member_id') as String),
        )
        .toList();
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
