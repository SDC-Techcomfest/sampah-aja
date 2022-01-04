import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampah_aja/models/guest_model.dart';

import '../models/notification_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore}) :
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel) async {
    try {
      await _firebaseFirestore.collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> createGuest(GuestModel guestModel) async {
    try {
      await _firebaseFirestore.collection('guest')
          .doc(guestModel.id)
          .set(guestModel.toJson());
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> deleteGuest(String id) async {
    try {
      await _firebaseFirestore.collection('guest')
          .doc(id).delete();
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<GuestModel> getGuestById() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final result = await _firebaseFirestore.collection('guest').doc(uid).get();
      return GuestModel.fromJson(result.data()!);
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      final result = await _firebaseFirestore.collection('users').doc(id).get();
      return UserModel.fromJson(result.data()!);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getAllUserAsGarbageCollector() async {
    List<UserModel> listUser = <UserModel>[];

    final result = await _firebaseFirestore.collection('users')
        .where('user', isEqualTo: 'Tukang Sampah')
        .get();

    for (var e in result.docs) {
      listUser.add(UserModel.fromJson(e.data()));
    }

    return listUser;
  }

  Future<List<UserModel>> getAllUserAsJunkCollector() async {
    List<UserModel> listUser = <UserModel>[];

    final result = await _firebaseFirestore.collection('users')
        .where('user', isEqualTo: 'Tukang Rongsokan')
        .get();

    for (var e in result.docs) {
      listUser.add(UserModel.fromJson(e.data()));
    }

    return listUser;
  }

  Future<void> sendNotification(NotificationModel notificationModel) async {
    try {
      await _firebaseFirestore.collection('notification')
          .doc(notificationModel.id)
          .set(notificationModel.toJson());
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _firebaseFirestore.collection('notification').doc(id).delete();
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<List<NotificationModel>> getAllNotification() async {
    List<NotificationModel> listNotification = <NotificationModel>[];

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final result = await _firebaseFirestore.collection('notification')
        .where('to', isEqualTo: uid)
        .get();

    for (var e in result.docs) {
      listNotification.add(NotificationModel.fromJson(e.data()));
      print("ASASASA ${e.data()['id']}");
    }

    return listNotification;
  }
}