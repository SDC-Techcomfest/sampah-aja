import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/notification_model.dart';
import '../repositories/user_repository.dart';
import '../utils/formz.dart';

class NotificationState extends Equatable {

  final List<NotificationModel> listNotification;
  final FormzStatus status;

  const NotificationState({
    this.listNotification = const <NotificationModel>[],
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [listNotification,status];

  NotificationState copyWith({
    List<NotificationModel>? listNotification,
    FormzStatus? status
  }) {
    return NotificationState(
      listNotification: listNotification ?? this.listNotification,
      status: status ?? this.status
    );
  }
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState()) {
    getAllNotification();
  }

  final _userRepository = UserRepository();

  Future<void> getAllNotification() async {
    try {
      final result = await _userRepository.getAllNotification();
      emit(state.copyWith(listNotification: result));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNotification(String id) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _userRepository.deleteNotification(id);
      emit(state.copyWith(
        listNotification: [],
          status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}