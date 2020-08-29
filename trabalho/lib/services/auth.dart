import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/house.dart';
import '../models/member.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _collection = FirebaseFirestore.instance.collection('users');

  Member _convertFromFirebase({
    @required String id,
    @required String email,
    @required String name,
    @required String nickname,
    @required String cpf,
    @required String dateOfBirth,
    House house,
  }) {
    return Member(
      id: id,
      email: email,
      name: name,
      nickname: nickname,
      cpf: cpf,
      dateOfBirth: dateOfBirth,
      house: house,
    );
  }

  Future<Member> registerMember({
    String id,
    String email,
    String name,
    String nickname,
    String cpf,
    String dateOfBirth,
    String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final result = await _collection.add({
      'name': name,
      'email': email,
      'nickname': nickname,
      'cpf': cpf,
      'dateOfBirth': dateOfBirth,
    });

    return _convertFromFirebase(
      id: result.id,
      name: name,
      email: email,
      nickname: nickname,
      cpf: cpf,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Member> signIn({String email, String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    final result = await _collection.where('email', isEqualTo: email).get();
    final user = result.docs.first;

    return _convertFromFirebase(
      id: user.id,
      email: user.get('email') as String,
      name: user.get('name') as String,
      nickname: user.get('nickname') as String,
      cpf: user.get('cpf') as String,
      dateOfBirth: user.get('dateOfBirth') as String,
    );
  }
}
