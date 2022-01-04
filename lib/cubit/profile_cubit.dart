import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/user_repository.dart';
import '../models/user_model.dart';

class ProfileState extends Equatable {

  final User? authUser;
  final UserModel? userModel;

  const ProfileState({
    this.authUser,
    this.userModel
  });

  @override
  List<Object?> get props => [authUser,userModel];

  ProfileState copyWith({
    User? authUser,
    UserModel? userModel
  }) {
    return ProfileState(
      authUser: authUser ?? this.authUser,
      userModel: userModel ?? this.userModel
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {

  late UserRepository _userRepository;

  ProfileCubit() : super(const ProfileState()) {
    _userRepository = UserRepository();

    Future.wait([getAuthProfile(), getProfile()]);
  }

  Future<void> getAuthProfile() async {
    final result = FirebaseAuth.instance.currentUser;
    emit(state.copyWith(authUser: result));
  }

  Future<void> getProfile() async {
    try {
      final result = await _userRepository.getUserById(state.authUser!.uid);
      emit(state.copyWith(userModel: result));
    } catch (e) {
      throw Exception(e);
    }
  }
}