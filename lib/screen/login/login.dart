import 'package:flutter/material.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/home/home.dart';
import 'package:uitest/state_management/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/state_management/events/login_events.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _fromstate = GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(25, 200, 25, 0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _fromstate,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Username:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: userNameController,
                            validator: (input) {
                              if (input!.length < 6 || input.isEmpty) {
                                return "Username should have more than 6 characters";
                              } else if (!RegExp(r'^[a-z A-Z 0-9 _ . @]+$')
                                  .hasMatch(input)) {
                                return "There are special word in your typing";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Password:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (input) => input!.length < 6 ||
                                    input.isEmpty
                                ? "Password should have more than 6 characters"
                                : null,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: blockColor,
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              if (!_fromstate.currentState!.validate()) {
                                return;
                              }
                              loginRequest.userName = userNameController.text;
                              loginRequest.password = passwordController.text;
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginEventRequested(
                                      loginRequest: loginRequest));

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                  (route) => false);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
