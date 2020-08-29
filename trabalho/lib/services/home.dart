import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/house.dart';
import '../models/member.dart';

class HouseService {
  final _collection = FirebaseFirestore.instance.collection('users');

  Future<House> create({
    String name,
    String address,
    String state,
    String city,
    Member firstManager,
  }) async {
    final result = await _collection.add({
      'name': name,
      'address': address,
      'state': state,
      'city': city,
      'members': [
        {'member_id': firstManager.id, 'is_manager': true}
      ]
    });

    final house = House(
      id: result.id,
      name: name,
      address: address,
      city: city,
      state: state,
    );

    house.addManager(firstManager);

    return house;
  }

  Future<void> addMember(final House house, final Member member) async {
    house.addMember(member);
  }
}
