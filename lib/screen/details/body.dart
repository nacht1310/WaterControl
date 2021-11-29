import 'package:flutter/material.dart';
import 'package:uitest/constant.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text(
            "Location: ${stations[0].stationAddress}",
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
