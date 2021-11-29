import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uitest/server/models/station_model.dart';

class StationRepositories {
  Future<List<Station>> getStationData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("login");
    // ignore: unused_local_variable
    List<Station> stations = [];
    var response = await http.get(
        Uri.parse('https://sampleapiproject.azurewebsites.net/stations/list'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return stations =
          jsonData.map((dynamic e) => Station.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
