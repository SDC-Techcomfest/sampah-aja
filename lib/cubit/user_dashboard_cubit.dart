import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/feed_model.dart';
import '../repositories/feed_repository.dart';
import '../utils/formz.dart';
import '../repositories/auth_repository.dart';

class UserDashboardState extends Equatable {

  final List<FeedModel>? listFeed;
  final FormzStatus status;

  const UserDashboardState({
    this.listFeed,
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [listFeed, status];

  UserDashboardState copyWith({
    List<FeedModel>? listFeed,
    FormzStatus? status
  }) {
    return UserDashboardState(
        listFeed: listFeed ?? this.listFeed,
        status: status ?? this.status
    );
  }
}

class UserDashboardCubit extends Cubit<UserDashboardState> {
  UserDashboardCubit() : super(const UserDashboardState()) {
    getAllFeed();
  }

  final _authRepository = AuthRepository();
  final _feedRepository = FeedRepository();

  Future<void> logout() async {
    try {
      await _authRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future<void> getAllFeed() async {
    try {
      final result = await _feedRepository.getAllFeed();
      emit(state.copyWith(listFeed: result));
    } on Exception {
      throw Exception();
    }
  }

}