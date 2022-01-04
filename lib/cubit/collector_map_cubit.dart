import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/guest_model.dart';
import '../models/notification_model.dart';
import '../repositories/user_repository.dart';
import '../models/user_model.dart';
import '../utils/formz.dart';

class CollectorMapState extends Equatable {

  final List<Marker>? markers;
  final Position? position;
  final List<UserModel>? users;
  final FormzStatus status;

  const CollectorMapState({
    this.markers,
    this.position,
    this.users,
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [markers, position, users, status];

  CollectorMapState copyWith({
    List<UserModel>? users,
    List<Marker>? markers,
    Position? position,
    FormzStatus? status
  }) {
    return CollectorMapState(
        users: users ?? this.users,
        markers: markers ?? this.markers,
        position: position ?? this.position,
      status: status ?? this.status
    );
  }
}

class CollectorMapCubit extends Cubit<CollectorMapState> {

  final bool garbageCollector;
  final int garbageSize;

  CollectorMapCubit(this.garbageCollector, this.garbageSize) : super(const CollectorMapState()) {
    getCurrentLocation();

    if (garbageCollector) {
      getGarbageCollector();
    } else {
      getJunkCollector();
    }
  }

  final _userRepository = UserRepository();

  Future<void> getCurrentLocation() async {
    try {
      final result = await Geolocator.getCurrentPosition();
      emit(state.copyWith(position: result));
    } catch(_) {
      throw Exception();
    }
  }

  Future<void> getJunkCollector() async {
    try {
      final result = await _userRepository.getAllUserAsJunkCollector();
      emit(state.copyWith(users: result));
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> getGarbageCollector() async {
    try {
      final result = await _userRepository.getAllUserAsGarbageCollector();
      emit(state.copyWith(users: result));
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> sendNotification(String id) async {

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final guest = await _userRepository.getGuestById();
      final documentID = const Uuid().v1();
      NotificationModel notificationModel = NotificationModel(
        id: documentID,
          title: 'Ada permintaan pengambilan sampah',
          address: guest.address,
          whatsapp: guest.whatsapp,
          garbageSize: garbageSize,
          from: guest.name,
          to: id,
          time: Timestamp.now(),
          position: guest.position
      );

      await _userRepository.sendNotification(notificationModel);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch(_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}