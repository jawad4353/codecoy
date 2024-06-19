part of 'draw_polyline_bloc.dart';

abstract class DrawPolyLineEvent extends Equatable {
  const DrawPolyLineEvent();
}


class DrawPolyLineLoadEvent extends DrawPolyLineEvent{
  final LatLng currentPosition;
  const DrawPolyLineLoadEvent(this.currentPosition);
  @override
  List<Object?> get props => [currentPosition];
}


class FetchLocationEvent extends DrawPolyLineEvent{
  final BuildContext context;
  const FetchLocationEvent(this.context);
  @override
  List<Object?> get props => [context];
}
