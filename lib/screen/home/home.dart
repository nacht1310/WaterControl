import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/details/details.dart';
import 'package:uitest/state_management/bloc/login_bloc.dart';
import 'package:uitest/state_management/events/station_events.dart';
import 'package:uitest/state_management/states/login_states.dart';
import 'circle_percentage.dart';
import 'package:uitest/screen/drawer.dart';
import 'package:uitest/screen/headings.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:uitest/state_management/states/station_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("login", state.loginResponse.token);
          BlocProvider.of<StationBloc>(context)
              .add(const StationEventRequested());
        }
      },
      builder: (context, state) {
        if (state is LoginSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
            ),
            drawer: const BuildDrawer(),
            body: BlocConsumer<StationBloc, StationState>(
              listener: (context, state) {
                if (state is StationSuccess) {
                  stations = [];
                  stations = state.station;
                  completer.complete();
                }
              },
              builder: (context, state) {
                if (state is StationSuccess) {
                  return RefreshIndicator(
                    onRefresh: () {
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
                                  stations[index]
                                      .processingSystem[0]
                                      .waterLevel,
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
                        }),
                  );
                }
                if (state is StationFailure) {
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
        if (state is LoginFailure) {
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
