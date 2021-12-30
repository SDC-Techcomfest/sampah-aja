import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/feed_model.dart';
import '../repositories/feed_repository.dart';
import '../utils/formz.dart';

class FeedDetailState extends Equatable {

  final FeedModel? feedModel;
  final FormzStatus status;

  const FeedDetailState({
    this.feedModel,
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [feedModel, status];

  FeedDetailState copyWith({
    FeedModel? feedModel,
    FormzStatus? status
  }) {
    return FeedDetailState(
      feedModel: feedModel ?? this.feedModel,
      status: status ?? this.status
    );
  }
 }

class FeedDetailCubit extends Cubit<FeedDetailState>{
  FeedDetailCubit() : super(const FeedDetailState());

  final _feedRepository = FeedRepository();

  Future<void> getFeedById(String id) async {
    try {
      final result = await _feedRepository.getFeedById(id);
      emit(state.copyWith(
        feedModel: result,
          status: FormzStatus.submissionSuccess
      ));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}