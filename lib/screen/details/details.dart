import 'package:flutter/material.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/details/body.dart';
import 'package:uitest/screen/drawer.dart';
import 'package:uitest/screen/headings.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:uitest/state_management/events/station_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/state_management/states/station_states.dart';

class Details extends StatelessWidget {
  final int i;
  const Details({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        HeadingBlock(i: i),
                        const BodyBlock(),
                        DataBlock(
                          dataName: "Water Level",
                          dataPercentage: waterPercentage(
                              stations[i].processingSystem[0].waterLevel),
                          dataLevel: stations[i].processingSystem[0].waterLevel,
                        ),
                        DataBlock(
                          dataName: "Chlorine Concenstration",
                          dataPercentage: chlorinePercentage(stations[i]
                              .processingSystem[0]
                              .chlorineConcentration),
                          dataLevel: stations[i]
                              .processingSystem[0]
                              .chlorineConcentration,
                        ),
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
}

class DataBlock extends StatelessWidget {
  final String dataName;
  final double dataPercentage;
  final int dataLevel;

  const DataBlock(
      {Key? key,
      required this.dataName,
      required this.dataLevel,
      required this.dataPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 350,
        height: 126,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: blockColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Text(
                dataName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LinearIndicator(dataPercentage),
              MaxMinValue(
                max: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyBlock extends StatelessWidget {
  const BodyBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 350,
        height: 86,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: blockColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: const [
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingBlock extends StatelessWidget {
  const HeadingBlock({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 250,
        height: 70,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: blockColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Headings(stations[i].stationName, 25),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MaxMinValue extends StatelessWidget {
  int max;
  MaxMinValue({Key? key, required this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 130, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              "0",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
            alignment: Alignment.centerRight,
            child: Text(
              "$max",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LinearIndicator extends StatelessWidget {
  final double _percentage;
  const LinearIndicator(this._percentage, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Stack(children: [
        LinearProgressIndicator(
          backgroundColor: Colors.white,
          color: percentageColor(_percentage),
          minHeight: 20,
          value: _percentage / 100,
        ),
        Center(
          child: Text("$_percentage%",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
