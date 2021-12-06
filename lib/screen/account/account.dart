import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../drawer.dart';

// ignore: must_be_immutable
class Account extends StatelessWidget {
  String? name;
  Account({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      drawer: const BuildDrawer(),
      body: Center(
        child: Text("$name"),
      ),
    );
  }
}
