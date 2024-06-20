import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:codecoy/network_config/network_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../model/directions_model.dart' show DirectionsResponse, Leg, Step ;
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
          LocationData ? data=await _location.getLocation();
           LatLng currentLocation=LatLng(data.latitude!, data.longitude!);
           List<Polyline> ? myPolylines=await createRoutePolyLine(initialLocation: currentLocation, destinationLocation: event.destinationLocation);
           emit((DrawPolyLineLoadedState(currentLocation, createMarkers(initialLocation: currentLocation,
              destinationLocation: event.destinationLocation), myPolylines)));

        }catch(a){
          print(a.toString());
          emit( const DrawPolyLineErrorState('Error loading map'));
        }
      }
    });
  }

  Set<Marker> createMarkers({required LatLng initialLocation, required destinationLocation}) {
    Set<Marker> markers = <Marker>{};
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


  List<Polyline> createStraightLine({required LatLng initialLocation,required destinationLocation }) {
    List<Polyline> polylines = [];
    if (destinationLocation != null) {
      polylines.add(
        Polyline(
          polylineId:  const PolylineId('route1'),
          color: AppColors.primary,
          width: 6,
          points: [initialLocation,destinationLocation ],
        ),
      );
    }
    return polylines;
  }



  Future<List<Polyline>> createRoutePolyLine({
    required LatLng initialLocation,
    required  destinationLocation,
  }) async {

    List<Polyline> polylines = [];
    ApiResponse response;
    if(destinationLocation==null){return polylines;}
    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${initialLocation.latitude},${initialLocation.longitude}&'
        'destination=${destinationLocation.latitude},${destinationLocation.longitude}&'
        'key=';

    try{
      response=await NetworkConfig.getApiCall(url);
      if(response.done??false){
        DirectionsResponse model=DirectionsResponse.fromJson(json.decode(response.responseString??""));
        if (model.routes[0].legs.isNotEmpty) {
          Leg leg = model.routes[0].legs[0];
          for (Step step in leg.steps) {
            List<LatLng> points = _decodePolyline(step.polyline.points);
            Polyline polyline = Polyline(
              polylineId: const PolylineId('route1'),
              color: AppColors.purple,
              width: 6,
              points: points,
            );
            polylines.add(polyline);
          }

        }
      }
    }catch(e){

    }
    return polylines;
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

      double latDouble = lat / 1e5;
      double lngDouble = lng / 1e5;
      points.add(LatLng(latDouble, lngDouble));
    }

    return points;
  }


}
