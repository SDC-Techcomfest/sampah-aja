import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/user_repository.dart';
import '../models/feed_model.dart';
import '../repositories/feed_repository.dart';
import '../utils/formz.dart';
import '../repositories/auth_repository.dart';

class GuestDashboardState extends Equatable {

  final List<FeedModel>? listFeed;
  final FormzStatus status;

  const GuestDashboardState({
    this.listFeed,
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [listFeed, status];

  GuestDashboardState copyWith({
    List<FeedModel>? listFeed,
    FormzStatus? status
  }) {
    return GuestDashboardState(
      listFeed: listFeed ?? this.listFeed,
        status: status ?? this.status
    );
  }
}

class GuestDashboardCubit extends Cubit<GuestDashboardState> {
  GuestDashboardCubit() : super(const GuestDashboardState()) {
    getAllFeed();
  }

  final _authRepository = AuthRepository();
  final _userRepository = UserRepository();
  final _feedRepository = FeedRepository();

  Future<void> logout() async {
    try {
      final user = _authRepository.getUser();
      await _authRepository.logOut();
      await _userRepository.deleteGuest(user!.uid);
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