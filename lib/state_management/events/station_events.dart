import 'package:equatable/equatable.dart';

abstract class StationEvent extends Equatable {
  const StationEvent();
}

class StationEventRequested extends StationEvent {
  const StationEventRequested();
  @override
  List<Object> get props => [];
}

class StationEventRefresh extends StationEvent {
  const StationEventRefresh();
  @override
  List<Object> get props => [];
}
