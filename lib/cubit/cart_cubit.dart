import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartState extends Equatable {

  final List<String> organicImage;
  final List<String> reusableImage;

  const CartState({
    this.organicImage = const <String>[],
    this.reusableImage = const <String>[]
  });

  @override
  List<Object?> get props => [organicImage, reusableImage];

  CartState copyWith({
    List<String>? organicImage,
    List<String>? reusableImage
  }) {
    return CartState(
      organicImage: organicImage ?? this.organicImage,
      reusableImage: reusableImage ?? this.reusableImage,
    );
  }
}

class CartCubit extends Cubit<CartState> {
  final List<String> organicImage;
  final List<String> reusableImage;
  CartCubit({required this.organicImage, required this.reusableImage}) : super(const CartState()) {
    emit(state.copyWith(
      organicImage: organicImage,
      reusableImage: reusableImage
    ));
  }

  void organicToReusable(String value) {
    emit(state.copyWith(
        organicImage: List.of(state.organicImage)..remove(value),
      reusableImage: List.of(state.reusableImage)..add(value)
    ));
  }

  void reusableToOrganic(String value) {
    emit(state.copyWith(
        organicImage: List.of(state.organicImage)..add(value),
        reusableImage: List.of(state.reusableImage)..remove(value)
    ));
  }

  void deleteImage(bool isOrganic, String value) {
    if (isOrganic) {
      emit(state.copyWith(
          organicImage: List.of(state.organicImage)..remove(value)
      ));
    } else {
      emit(state.copyWith(
          reusableImage: List.of(state.reusableImage)..remove(value)
      ));
    }
  }
}