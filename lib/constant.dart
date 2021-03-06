import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/server/models/login_model.dart';
import 'package:uitest/server/models/station_model.dart';
import 'dart:async';

List<Station> stations = [];
LoginRequest loginRequest = LoginRequest(userName: '', password: '');
LoginResponse loginResponseData = LoginResponse();

const primaryColor = Color(0xFF032B91);
const textColor = Colors.white;
const blockColor = Color(0xEBEBEBFF);
const tabColor = Color(0x5978C9FF);

final Completer completer = Completer();

double waterPercentage(int waterLevel) {
  return waterLevel * 100 / 10;
}

double chlorinePercentage(int chlorineConcenstration) {
  return chlorineConcenstration * 100 / 100;
}

double? percentage;
Color percentageColor(percentage) {
  return (percentage >= 70)
      ? const Color(0xFF06FB05)
      : (percentage >= 40)
          ? Colors.yellow
          : Colors.red;
}
