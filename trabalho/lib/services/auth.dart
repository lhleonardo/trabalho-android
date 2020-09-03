import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/member.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _collection = FirebaseFirestore.instance.collection('users');

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future<QueryDocumentSnapshot> _getUser(String email) async {
    final result = await _collection.where('email', isEqualTo: email).get();
    final user = result.docs.first;
    return user;
  }

  Future<Member> getUser(String email) async {
    final result = await _collection.where('email', isEqualTo: email).get();
    final user = result.docs.first;
    return Member.fromMap(user.data(), user.id);
  }

  Future<Member> registerMember({
    @required String email,
    @required String name,
    @required String nickname,
    @required String cpf,
    @required String dateOfBirth,
    @required String password,
  }) async {
    final userAuth = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // cria um usuário em /users com o mesmo id presente no usuário
    // cadastrado na autenticação
    await _collection.doc(userAuth.user.uid).set({
      'name': name,
      'email': email,
      'nickname': nickname,
      'cpf': cpf,
      'dateOfBirth': dateOfBirth,
    });

    return Member(
      id: userAuth.user.uid,
      name: name,
      email: email,
      nickname: nickname,
      cpf: cpf,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<void> editMember({
    @required String email,
    @required String name,
    @required String nickname,
    @required String dateOfBirth,
    @required String userId,
  }) async {
    // atualiza um usuário
    await _collection.doc(userId).update({
      'name': name,
      'email': email,
      'nickname': nickname,
      'dateOfBirth': dateOfBirth,
    });
  }

  Future<void> logout() {
    return _auth.signOut();
  }

  Future<Member> signIn({String email, String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final QueryDocumentSnapshot user = await _getUser(email);
    return Member.fromMap(user.data(), user.id);
  }
}
