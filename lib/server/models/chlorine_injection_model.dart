import 'package:equatable/equatable.dart';

class ChlorineInjection extends Equatable {
  final int? chlorineInjectionId;
  final int? chlorineVolume;
  final String? employeeName;
  final String? injectionTime;
  final int? processingSystemId;

  const ChlorineInjection(
      {this.chlorineInjectionId,
      this.chlorineVolume,
      this.employeeName,
      this.injectionTime,
      this.processingSystemId});
  @override
  List<Object?> get props => [chlorineInjectionId, processingSystemId];
  factory ChlorineInjection.fromJson(Map<String, dynamic> json) {
    return ChlorineInjection(
      chlorineInjectionId: json['chlorineInjectionId'],
      chlorineVolume: json['amountOfChlorine'],
      employeeName: json['employeeName'],
      injectionTime: json['injectionTime'],
      processingSystemId: json['processingSystemId'],
    );
  }
}
