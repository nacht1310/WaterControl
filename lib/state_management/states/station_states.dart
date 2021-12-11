import 'package:equatable/equatable.dart';
import 'package:uitest/server/models/station_model.dart';

abstract class StationState extends Equatable {
  const StationState();
  @override
  List<Object?> get props => [];
}

class StationInitial extends StationState {}

class StationSuccess extends StationState {
  final List<Station> station;
  final DateTime timestamp;
  const StationSuccess({required this.station, required this.timestamp});
  @override
  List<Object?> get props => [station, timestamp];
}

class StationFailure extends StationState {}
