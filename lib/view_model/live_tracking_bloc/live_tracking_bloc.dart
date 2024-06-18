import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
part 'live_tracking._event.dart';
part 'live_tracking._state.dart';

class LiveTrackingBloc extends Bloc<LiveTrackingEvent, LiveTrackingState> {
  final Location _location = Location();

  LiveTrackingBloc() : super(LiveTrackingInitial()) {
    _location.onLocationChanged.listen((LocationData currentLocation) {
      final currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      add(LocationChangedEvent(currentPosition));
    });
  }

  @override
  Stream<LiveTrackingState> mapEventToState(LiveTrackingEvent event) async* {
    if (event is LocationChangedEvent) {
      yield LiveTrackingLoadedState(event.currentPosition);
    }
  }
}
