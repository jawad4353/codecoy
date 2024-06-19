import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/location_adapter.dart';
part 'location_history_events.dart';
part 'location_history_state.dart';

class LocationHistoryBloc extends Bloc<LocationHistoryEvent, LocationHistoryState> {
  List<Location> listHistory=[];
  LocationHistoryBloc() : super(LocationHistoryInitial()) {
    on<LocationHistoryEvent>((event, emit) async{
      if(event is LocationHistoryLoadEvent){
        try {
          listHistory.clear();
          final box = await Hive.openBox('locations');
          for (int i = 0; i < box.length; i++) {
            Location a=box.getAt(i) as Location;
            listHistory.add(box.getAt(i) as Location);
          }
          emit(LocationHistoryLoadedState(listHistory));
          await box.close();

        } catch (e) {
         emit(LocationHistoryErrorState(e.toString()));
        }

        }

    });
  }
}
