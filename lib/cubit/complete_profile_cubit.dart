import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../utils/formz.dart';
import '../utils/validators/default_validator.dart';

class CompleteProfileState extends Equatable {

  final Default name;
  final Default address;
  final Default userType;
  final Default whatsappNumber;
  final Position? position;
  final FormzStatus status;

  const CompleteProfileState({
    this.name = const Default.pure(),
      this.address = const Default.pure(),
      this.userType = const Default.pure(),
      this.whatsappNumber = const Default.pure(),
    this.position,
      this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [name, address, userType, whatsappNumber, position, status];

  CompleteProfileState copyWith({
    Default? name,
    Default? address,
    Default? userType,
    Default? whatsappNumber,
    Position? position,
    FormzStatus? status,
  }) {
    return CompleteProfileState(
      name: name ?? this.name,
      address: address ?? this.address,
      userType: userType ?? this.userType,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      position: position ?? this.position,
      status: status ?? this.status
    );
  }
}

class CompleteProfileCubit extends Cubit<CompleteProfileState>{
  CompleteProfileCubit() : super(const CompleteProfileState());

  final _userRepository = UserRepository();

  void nameChanged(String value) {
    final name = Default.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.address,
        state.userType,
        state.whatsappNumber
      ]),
    ));
  }

  void addressChanged(String value) {
    final address = Default.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([
        state.name,
        address,
        state.userType,
        state.whatsappNumber
      ]),
    ));
  }

  void userTypeChanged(String value) {
    final userType = Default.dirty(value);
    emit(state.copyWith(
      userType: userType,
      status: Formz.validate([
        state.name,
        state.address,
        userType,
        state.whatsappNumber
      ]),
    ));
  }

  void whatsappNumberChanged(String value) {
    final whatsappNumber = Default.dirty(value);
    emit(state.copyWith(
      whatsappNumber: whatsappNumber,
      status: Formz.validate([
        state.name,
        state.address,
        state.userType,
        whatsappNumber
      ]),
    ));
  }

  Future<void> getCurrentLocation() async {
    try {
      final result = await Geolocator.getCurrentPosition();
      emit(state.copyWith(position: result));
    } catch(_) {
      throw Exception();
    }
  }

  Future<void> submit() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await getCurrentLocation();

      String uid = FirebaseAuth.instance.currentUser!.uid;
      final userModel = UserModel(
        id: uid,
        name: state.name.value,
        address: state.address.value,
        user: state.userType.value,
        whatsapp: state.whatsappNumber.value,
        position: GeoPoint(state.position!.latitude, state.position!.longitude)
      );

      await _userRepository.createUser(userModel);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch(_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}