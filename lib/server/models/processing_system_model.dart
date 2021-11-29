import 'package:equatable/equatable.dart';
import 'package:uitest/server/models/chlorine_injection_model.dart';

class ProcessingSystem extends Equatable {
  final int? processingSystemID;
  final String? processingSystemName;
  final int? waterLevel;
  final int? waterPressure;
  final int? chlorineConcentration;
  final int? stationID;
  final List<ChlorineInjection>? chlorineInjection;

  const ProcessingSystem(
      {this.chlorineConcentration,
      this.processingSystemID,
      this.processingSystemName,
      this.stationID,
      this.waterLevel,
      this.waterPressure,
      this.chlorineInjection});
  @override
  List<Object?> get props => [
        processingSystemID,
        stationID,
        chlorineConcentration,
        processingSystemName,
        waterLevel,
        waterPressure,
        chlorineInjection
      ];

  factory ProcessingSystem.fromJson(Map<String, dynamic> json) {
    return ProcessingSystem(
      processingSystemID: json['processingSystemID'],
      processingSystemName: json['processingSystemName'],
      waterLevel: json['waterLevel'],
      waterPressure: json['waterPressure'],
      chlorineConcentration: json['chlorineConcentration'],
      stationID: json['stationID'],
      chlorineInjection: json['chlorineInjections'] == null
          ? null
          : (json['chlorineInjections'] as List)
              .map((e) => ChlorineInjection.fromJson(e))
              .toList(),
    );
  }
}
