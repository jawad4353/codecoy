import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../main.dart';
import '../../utilis/app_preferences.dart';
part 'draw_polyline_event.dart';
part 'draw_polyline_state.dart';

class DrawPolyLineBloc extends Bloc<DrawPolyLineEvent, DrawPolyLineState> {
  Location _location=new Location();
  DrawPolyLineBloc() : super(DrawPolyLineInitial()) {
    on<DrawPolyLineEvent>((event, emit) async{
      if(event is DrawPolyLineLoadEvent){
        emit((DrawPolyLineLoadedState(event.currentPosition)));
      }

      if(event is FetchLocationEvent){
        try{
          emit(const DrawPolyLineLoadingState());
          LocationData data=await _location.getLocation();
          preferences.setDouble(AppPrefs.keyLatitude, data.latitude??0.0);
          preferences.setDouble(AppPrefs.keyLongitude, data.longitude??0.0);
          emit((DrawPolyLineLoadedState(LatLng(data.latitude!, data.longitude!))));

        }catch(a){
          emit( const DrawPolyLineErrorState('Unable to fetch location. Try again !'));
        }
      }
    });
  }




}
