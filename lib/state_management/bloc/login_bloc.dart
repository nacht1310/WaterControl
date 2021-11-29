import 'package:uitest/state_management/events/login_events.dart';
import 'package:uitest/state_management/states/login_states.dart';
import 'package:uitest/server/repositories/login_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/server/models/login_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial());
  @override
  // ignore: avoid_renaming_method_parameters
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    if (loginEvent is LoginEventRequested) {
      try {
        LoginResponse login =
            await loginRepository.getToken(loginEvent.loginRequest);
        yield LoginSuccess(loginResponse: login);
      } catch (exception) {
        yield LoginFailure();
      }
    }
  }
}
