import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/auth_repository.dart';
import '../utils/formz.dart';
import '../utils/validators/validators.dart';

enum ConfirmPasswordValidationError { invalid }

class RegisterState extends Equatable {

  const RegisterState({
    this.firstName = const Default.pure(),
    this.lastName = const Default.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Default firstName;
  final Default lastName;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [firstName, lastName, email, password, confirmedPassword, status];

  RegisterState copyWith({
    Default? firstName,
    Default? lastName,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final _authRepository = AuthRepository();

  void firstNameChanged(String value) {
    final firstName = Default.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.password,
        state.confirmedPassword
      ]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = Default.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        state.firstName,
        lastName,
        state.email,
        state.password,
        state.confirmedPassword
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        email,
        state.password,
        state.confirmedPassword
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> submit() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
          name: "${state.firstName.value} ${state.lastName.value}",
          email: state.email.value,
          password: state.password.value
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}