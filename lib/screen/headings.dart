import 'package:flutter/material.dart';

class Headings extends StatelessWidget {
  final String? _stationName;
  final double _size;

  const Headings(this._stationName, this._size, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        "$_stationName",
        style: TextStyle(
          fontSize: _size,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
