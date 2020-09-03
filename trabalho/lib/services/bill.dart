import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/models/member.dart';

class BillService {
  final _collection = FirebaseFirestore.instance.collection('houses');

  Future<void> create(
    String houseId, {
    String title,
    String description,
    double price,
    String category,
    List<Member> recipients,
    String ownerId,
  }) async {
    final billsCollection = _collection.doc(houseId).collection('bills');

    final Map<String, bool> relations = {};
    for (final member in recipients) {
      relations[member.id] = false;
    }

    await billsCollection.add({
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'recipients': relations,
      'owner_id': ownerId,
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

  Stream<List<Bill>> getBillsForHouse(String houseId) {
    final billsCollection = _collection.doc(houseId).collection('bills');

    return billsCollection.snapshots().map(_convertToBill);
  }

  Future<void> markAsPaid(
      {String houseId, String billId, String memberId}) async {
    final doc = _collection.doc(houseId).collection('bills').doc(billId);
    final billItem = await doc.get();

    final receipts = billItem.get('recipients');
    receipts[memberId] = true;

    await doc.update({'recipients': receipts});
  }
}
