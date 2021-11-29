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
  const StationSuccess({required this.station});
  @override
  List<Object?> get props => [station];
}

class StationFailure extends StationState {}
