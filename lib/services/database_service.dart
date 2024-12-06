import 'package:ServXFactory/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Kullanıcıyı Firestore'dan çekip saklama
  Future<void> fetchUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data() as Map<String, dynamic>);
        notifyListeners(); // Dinleyicilere bildir
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  // Kullanıcıyı Firestore'a ekleme
  Future<void> addUser(UserModel user) async {
    try {
      // Kullanıcı verisini Firestore'a kaydediyoruz
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      notifyListeners();
    } catch (e) {
      print("User add failed: $e");
    }
  }

  // Kullanıcı bilgilerini güncelleme
  // Kullanıcı bilgilerini güncelleme
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      _currentUser = user; // Güncel kullanıcıyı sakla
      notifyListeners(); // Dinleyicilere bildir
    } catch (e) {
      print("User update failed: $e");
    }
  }

  // Kullanıcıyı Firestore'dan silme
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      notifyListeners();
    } catch (e) {
      print("User delete failed: $e");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("User reset password failed: $e");
    }
  }

  // Kullanıcı bilgilerini Firestore'dan çekme
  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      notifyListeners();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        print("No user found with the given ID");
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  // Kullanıcı listesi çekme
  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }
}
