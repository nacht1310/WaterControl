import 'package:equatable/equatable.dart';
import 'package:uitest/server/models/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEventRequested extends LoginEvent {
  final LoginRequest loginRequest;
  const LoginEventRequested({required this.loginRequest});
  @override
  List<Object> get props => [loginRequest];
}
