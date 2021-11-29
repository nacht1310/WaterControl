import 'package:flutter/material.dart';
import 'package:uitest/screen/drawer.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/history/history_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/state_management/states/station_states.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:uitest/state_management/events/station_events.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Injection History"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "${stations[0].stationName}",
                  icon: const Icon(Icons.work),
                ),
                Tab(
                  text: "${stations[1].stationName}",
                  icon: const Icon(Icons.work),
                ),
                Tab(
                  text: "${stations[2].stationName}",
                  icon: const Icon(Icons.work),
                ),
              ],
            ),
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
                  child: const TabBarView(children: [
                    Page(1),
                    Page(2),
                    Page(3),
                  ]),
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
          )),
    );
  }
}

// ignore: must_be_immutable
class Page extends StatelessWidget {
  final int _stationNumber;

  const Page(this._stationNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations[_stationNumber - 1]
          .processingSystem[0]
          .chlorineInjection
          .length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 350,
                height: 125,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      HistoryData(_stationNumber - 1, index),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
