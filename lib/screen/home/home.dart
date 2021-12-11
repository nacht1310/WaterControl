import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/account/account.dart';
import 'package:uitest/screen/details/details.dart';
import 'package:uitest/state_management/bloc/login_bloc.dart';
import 'package:uitest/state_management/events/station_events.dart';
import 'package:uitest/state_management/states/login_states.dart';
import '../login_notification.dart';
import 'circle_percentage.dart';
import 'package:uitest/screen/drawer.dart';
import 'package:uitest/screen/headings.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:uitest/state_management/states/station_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<DateTime> scheduledTime = [];
  int id = 0;

  @override
  Widget build(BuildContext context) {
    void onClickedNotification(String? payload) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Account()),
      );
    }

    void listenNotification() =>
        LoginNotification.onNotification.stream.listen(onClickedNotification);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("login", state.loginResponse.token);
          BlocProvider.of<StationBloc>(context)
              .add(const StationEventRequested());
        }
      },
      builder: (context, loginState) {
        if (loginState is LoginSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
            ),
            drawer: const BuildDrawer(),
            body: BlocConsumer<StationBloc, StationState>(
              listener: (context, state) {
                if (state is StationSuccess) {
                  stations = state.station;
                  completer.complete();
                }
              },
              builder: (context, stationState) {
                if (stationState is StationSuccess) {
                  if (emailContainer.isEmpty) {
                    if (DateTime.now().hour > 7 && DateTime.now().hour < 22) {
                      scheduledTime.add(DateTime.now());
                      for (int i = 1; i < 10; i++) {
                        scheduledTime.add(scheduledTime[i - 1]
                            .add(const Duration(seconds: 10)));
                        id++;
                        LoginNotification.showScheduledNotifications(
                            id: id,
                            payload: "Move to Account Screen",
                            title: "Login Safety",
                            body:
                                "Let's verify your account and setting your email.",
                            scheduleTime: scheduledTime[i]);
                      }

                      // if (scheduledTime.isBefore(DateTime.now())) {
                      //   scheduledTime.add(const Duration(minutes: 1));
                      //   id++;
                      // }
                    }
                  } else {
                    LoginNotification.cancelAllNotifications();
                  }
                  listenNotification();
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<StationBloc>(context)
                          .add(const StationEventRefresh());
                      return completer.future;
                    },
                    child: ListView.builder(
                      itemCount: stations.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TabBlock(
                                index,
                                stations[index].processingSystem[0].waterLevel,
                                waterPercentage(stations[index]
                                    .processingSystem[0]
                                    .waterLevel),
                                stations[index]
                                    .processingSystem[0]
                                    .chlorineConcentration,
                                chlorinePercentage(stations[index]
                                    .processingSystem[0]
                                    .chlorineConcentration),
                                stations[index].stationName),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (stationState is StationFailure || stations.isEmpty) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        }
        if (loginState is LoginFailure) {
          return const Center(
            child: Text("Your User Name or Password is incorrect"),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class TabBlock extends StatelessWidget {
  final double _waterPercentageData, _chlorinePercentageData;

  final int _waterLevelData, _chlorineConcenstrationData, i;
  final String? _stationName;
  const TabBlock(
      this.i,
      this._waterLevelData,
      this._waterPercentageData,
      this._chlorineConcenstrationData,
      this._chlorinePercentageData,
      this._stationName,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<StationBloc>(context).add(const StationEventRefresh());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(i: i)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 390,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Headings(_stationName, 35),
                DataSummarize(
                  _waterLevelData,
                  _waterPercentageData,
                  _chlorineConcenstrationData,
                  _chlorinePercentageData,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataSummarize extends StatelessWidget {
  final double _waterPercentageData, _chlorinePercentageData;
  final int _waterLevelData, _chlorineConcenstrationData;
  const DataSummarize(this._waterLevelData, this._waterPercentageData,
      this._chlorineConcenstrationData, this._chlorinePercentageData,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Water Level",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Circle(_waterPercentageData, _waterLevelData),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Chlorine Concenstration",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child:
                  Circle(_chlorinePercentageData, _chlorineConcenstrationData),
            )
          ],
        )
      ],
    );
  }
}
