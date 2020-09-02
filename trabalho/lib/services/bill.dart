import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/models/member.dart';

class BillService {
  final _collection = FirebaseFirestore.instance.collection('houses');

  Future<void> create(
    String houseId, {
    String description,
    double price,
    String category,
    List<Member> recipients,
  }) async {
    final billsCollection = _collection.doc(houseId).collection('bills');

    final Map<String, bool> relations = {};
    for (final member in recipients) {
      relations[member.id] = false;
    }

    await billsCollection.add({
      'price': price,
      'description': description,
      'category': category,
      'recipients': relations,
    });
  }

  Stream<List<Bill>> getBillsForMember({
    @required String houseId,
    @required String memberId,
  }) {
    final billsCollection = _collection.doc(houseId).collection('bills');

    return billsCollection
        .where('recipients.$memberId', isEqualTo: false)
        .snapshots()
        .map(_convertToBill);
  }

  List<Bill> _convertToBill(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((document) => Bill.fromMap(document.data(), document.id))
        .toList();
  }
}
