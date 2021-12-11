import 'package:uitest/state_management/events/station_events.dart';
import 'package:uitest/state_management/states/station_states.dart';
import 'package:uitest/server/repositories/station_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uitest/server/models/station_model.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final StationRepositories stationRepositories;
  StationBloc({required this.stationRepositories}) : super(StationInitial());
  @override
  // ignore: avoid_renaming_method_parameters
  Stream<StationState> mapEventToState(StationEvent stationEvent) async* {
    if (stationEvent is StationEventRequested) {
      try {
        List<Station> stations = await stationRepositories.getStationData();
        yield StationSuccess(station: stations, timestamp: DateTime.now());
      } catch (exception) {
        yield StationFailure();
      }
    } else if (stationEvent is StationEventRefresh) {
      try {
        List<Station> stations = await stationRepositories.getStationData();
        yield StationSuccess(station: stations, timestamp: DateTime.now());
      } catch (exception) {
        yield StationFailure();
      }
    }
  }
}
