import 'package:flutter/material.dart';
import 'package:uitest/screen/login/login.dart';
import 'package:uitest/screen/login_notification.dart';
import 'package:uitest/server/repositories/login_repositories.dart';
import 'package:uitest/server/repositories/station_repositories.dart';
import 'package:uitest/state_management/bloc/login_bloc.dart';
import 'package:uitest/state_management/bloc/login_bloc_observer.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/state_management/bloc/station_bloc_observer.dart';

void main() {
  Bloc.observer = LoginBlocObserver();
  Bloc.observer = StationBlocObserver();

  final StationRepositories stationRepository = StationRepositories();
  final LoginRepository loginRepository = LoginRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => StationBloc(
                  stationRepositories: stationRepository,
                )),
        BlocProvider(
            create: (context) => LoginBloc(loginRepository: loginRepository)),
      ],
      child: UiTest(
        stationRepository: stationRepository,
        loginRepository: loginRepository,
      ),
    ),
  );
}

class UiTest extends StatefulWidget {
  final LoginRepository loginRepository;
  final StationRepositories stationRepository;
  const UiTest(
      {Key? key,
      required this.stationRepository,
      required this.loginRepository})
      : super(key: key);

  @override
  _UiTestState createState() => _UiTestState();
}

class _UiTestState extends State<UiTest> {
  @override
  void initState() {
    super.initState();
    LoginNotification.init(initSchedule: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<StationBloc>(context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<LoginBloc>(context),
          )
        ],
        child: Login(),
      ),
    ));
  }
}
