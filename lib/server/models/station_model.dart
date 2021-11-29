import 'package:equatable/equatable.dart';
import 'package:uitest/server/models/processing_system_model.dart';

class Station extends Equatable {
  final int? stationId;
  final String? stationName;
  final String? stationAddress;
  // ignore: prefer_typing_uninitialized_variables
  final processingSystem;
  final int? waterLevel;

  const Station(
      {this.stationId,
      this.stationName,
      this.stationAddress,
      this.processingSystem,
      this.waterLevel});

  @override
  List<Object?> get props => [stationId];

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationId: json['stationID'],
      stationName: json['stationName'],
      stationAddress: json['stationAddress'],
      processingSystem: json['processingSystems'] == null
          ? []
          : json['processingSystems']
              .map((e) => ProcessingSystem.fromJson(e))
              .toList(),
    );
  }
}
