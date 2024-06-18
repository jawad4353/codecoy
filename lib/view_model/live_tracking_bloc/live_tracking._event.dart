part of 'live_tracking_bloc.dart';

abstract class LiveTrackingEvent extends Equatable {
  const LiveTrackingEvent();
}


class LiveTrackingLoadingEvent extends LiveTrackingEvent{
  const LiveTrackingLoadingEvent();
  @override
  List<Object?> get props => [];
}


class LocationChangedEvent extends LiveTrackingEvent{
  final LatLng currentPosition;
  const LocationChangedEvent(this.currentPosition);
  @override
  List<Object?> get props => [];
}
