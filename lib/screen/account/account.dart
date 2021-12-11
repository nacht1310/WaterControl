import 'package:flutter/material.dart';
import '../../constant.dart';
import '../drawer.dart';
import '../login_notification.dart';

// ignore: must_be_immutable
class Account extends StatelessWidget {
  Account({
    Key? key,
  }) : super(key: key);
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      drawer: const BuildDrawer(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Container(
                decoration: BoxDecoration(
                    color: blockColor, borderRadius: BorderRadius.circular(15)),
                height: 50,
                width: double.infinity,
                child: TextButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    emailContainer.add(emailController.text);
                    LoginNotification.cancelAllNotifications();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
