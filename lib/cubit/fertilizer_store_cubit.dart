import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/fertilizer_store_model.dart';
import '../repositories/fertilizer_store_repository.dart';

class FertilizerStoreState extends Equatable {

  final List<FertilizerStoreModel>? fertilizerStore;
  final List<Marker>? markers;
  final Position? position;

  const FertilizerStoreState({
    this.fertilizerStore,
    this.markers,
    this.position,
  });

  @override
  List<Object?> get props => [fertilizerStore, markers, position];

  FertilizerStoreState copyWith({
    List<FertilizerStoreModel>? fertilizerStore,
    List<Marker>? markers,
    Position? position
  }) {
    return FertilizerStoreState(
      fertilizerStore: fertilizerStore ?? this.fertilizerStore,
        markers: markers ?? this.markers,
        position: position ?? this.position
    );
  }
}

class FertilizerStoreCubit extends Cubit<FertilizerStoreState> {
  FertilizerStoreCubit() : super(const FertilizerStoreState()) {
    Future.wait([
      getFertilizerStore(), getCurrentLocation()
    ]);
  }

  final _fertilizerStoreRepository = FertilizerStoreRepository();

  Future<void> getCurrentLocation() async {
    try {
      final result = await Geolocator.getCurrentPosition();
      emit(state.copyWith(position: result));
    } catch(_) {
      throw Exception();
    }
  }

  Future<void> getFertilizerStore() async {
    try {
      final result = await _fertilizerStoreRepository.getFertilizerStore();
      emit(state.copyWith(fertilizerStore: result));
    } catch(_) {
      throw Exception();
    }
  }
}