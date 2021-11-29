import 'package:equatable/equatable.dart';
import 'package:uitest/server/models/login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  const LoginSuccess({required this.loginResponse});
  @override
  List<Object?> get props => [loginResponse];
}

class LoginFailure extends LoginState {}
