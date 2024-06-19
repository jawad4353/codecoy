import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../utilis/app_colors.dart';
part 'draw_polyline_event.dart';
part 'draw_polyline_state.dart';

class DrawPolyLineBloc extends Bloc<DrawPolyLineEvent, DrawPolyLineState> {
  Location _location=new Location();
  DrawPolyLineBloc() : super(DrawPolyLineInitial()) {
    on<DrawPolyLineEvent>((event, emit) async{
      if(event is FetchLocationEvent){
        try{
          emit(const DrawPolyLineLoadingState());
          LocationData data=await _location.getLocation();
          LatLng currentLocation=LatLng(data.latitude!, data.longitude!);
          emit((DrawPolyLineLoadedState(currentLocation,
            _createMarkers(initialLocation: currentLocation, destinationLocation: event.destinationLocation),
              _createPolylines(initialLocation: currentLocation, destinationLocation: event.destinationLocation),
          )));

        }catch(a){
          emit( const DrawPolyLineErrorState('Unable to fetch location. Try again !'));
        }
      }
    });
  }

  Set<Marker> _createMarkers({required LatLng initialLocation, required destinationLocation}) {
    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId("current_location"),
        position: initialLocation,
        infoWindow: const InfoWindow(
          title: "Current Location",
        ),
      ),
    );
    if (destinationLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("destination_location"),
          position: destinationLocation,
          infoWindow: const InfoWindow(
            title: "Destination Location",
          ),
        ),
      );
    }

    return markers;
  }


  List<Polyline> _createPolylines({required LatLng initialLocation,required destinationLocation }) {
    List<Polyline> polylines = [];
    if (destinationLocation != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route1'),
          color: AppColors.primary,
          width: 3,
          points: [initialLocation,destinationLocation ],
        ),
      );
    }
    return polylines;
  }



}
