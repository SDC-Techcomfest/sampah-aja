import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/guest_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/formz.dart';
import '../utils/validators/default_validator.dart';

class LoginGuestState extends Equatable {

  final Default name;
  final Default whatsapp;
  final FormzStatus status;

  const LoginGuestState({
    this.name = const Default.pure(),
    this.whatsapp = const Default.pure(),
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [name, whatsapp, status];

  LoginGuestState copyWith({
    Default? name,
    Default? whatsapp,
    FormzStatus? status
  }) {
    return LoginGuestState(
      name: name ?? this.name,
      whatsapp: whatsapp ?? this.whatsapp,
      status: status ?? this.status
    );
  }
}

class LoginGuestCubit extends Cubit<LoginGuestState> {
  LoginGuestCubit() : super(const LoginGuestState());

  final _userRepository = UserRepository();
  final _authRepository = AuthRepository();

  void nameChanged(String value) {
    final name = Default.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.whatsapp
      ]),
    ));
  }

  void whatsappChanged(String value) {
    final whatsapp = Default.dirty(value);
    emit(state.copyWith(
      whatsapp: whatsapp,
      status: Formz.validate([
        state.name,
        whatsapp
      ]),
    ));
  }

  Future<void> submit() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final user = await _authRepository.signInAsGuest();
      final position = await getCurrentLocation();
      final address = await getAddressFromPosition(position);

      final guestModel = GuestModel(
        id: user!.uid,
        name: state.name.value,
        whatsapp: state.whatsapp.value,
        address: address,
        position: GeoPoint(position.latitude, position.longitude)
      );
      await _userRepository.createGuest(guestModel);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      final result = await Geolocator.getCurrentPosition();
      return result;
    } catch(_) {
      throw Exception();
    }
  }

  Future<String> getAddressFromPosition(Position position) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  }
}