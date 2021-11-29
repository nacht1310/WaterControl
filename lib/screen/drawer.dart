import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uitest/constant.dart';
import 'package:uitest/screen/history/history.dart';
import 'package:uitest/screen/home/home.dart';
import 'package:uitest/screen/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/state_management/bloc/station_bloc.dart';
import 'package:uitest/state_management/states/station_states.dart';
import 'package:uitest/state_management/events/station_events.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Flexible(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: tabColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/Avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: const Center(
                                child: Text(
                              "Username: Cyclone Nacht",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                          ),
                          Row(children: [
                            const Icon(Icons.home, size: 25),
                            Flexible(
                              child: ListTile(
                                title: const Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                onTap: () {
                                  BlocProvider.of<StationBloc>(context)
                                      .add(const StationEventRefresh());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (x) => BlocProvider.value(
                                              value:
                                                  BlocProvider.of<StationBloc>(
                                                      context),
                                              child: BlocConsumer<StationBloc,
                                                  StationState>(
                                                listener: (context, state) {
                                                  if (state is StationSuccess) {
                                                    stations = state.station;
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state is StationSuccess) {
                                                    return const Home();
                                                  }
                                                  if (state is StationFailure) {
                                                    return const Center(
                                                      child: Text(
                                                          "Something went wrong"),
                                                    );
                                                  }
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                            )),
                                  );
                                },
                              ),
                            ),
                          ]),
                          Row(
                            children: [
                              const Icon(Icons.filter_list_alt, size: 25),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "List",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.history, size: 25),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Injection History",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const History()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.account_circle, size: 25),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Account",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.settings,
                                size: 25,
                              ),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Settings",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.help,
                                size: 25,
                              ),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Help",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.report,
                                size: 25,
                              ),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Report",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 25,
                              ),
                              Flexible(
                                child: ListTile(
                                  title: const Text(
                                    "Log Out",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onTap: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    await pref.clear();
                                    stations = [];
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                        (route) => false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
