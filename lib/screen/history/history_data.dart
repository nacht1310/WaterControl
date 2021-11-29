import 'package:flutter/material.dart';
import 'package:uitest/constant.dart';

class HistoryData extends StatelessWidget {
  final int _number, _stationNumber;
  const HistoryData(this._stationNumber, this._number, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 25),
              Text(
                "${stations[_stationNumber].processingSystem[0].chlorineInjection[_number].injectionTime}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            children: [
              const Icon(Icons.account_box_rounded, size: 25),
              Text(
                "${stations[_stationNumber].processingSystem[0].chlorineInjection[_number].employeeName}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text(
            "Chlorine: +${stations[_stationNumber].processingSystem[0].chlorineInjection[_number].chlorineVolume}ml",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
