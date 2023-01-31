part of 'forgot_password_controller.dart';

class ForgotPaswordState extends Equatable {
  final Email email;
  final FormzStatus status;
  final String? errorMessage;

  const ForgotPaswordState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  ForgotPaswordState copyWith({
    Email? email,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ForgotPaswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, status];
}
