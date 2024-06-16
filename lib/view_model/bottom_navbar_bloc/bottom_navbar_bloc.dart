import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'bottom_navbar_events.dart';
part 'bottom_navbar_states.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarStates> {
  BottomNavBarBloc() : super(BottomNavBarInitialState()) {
    on<BottomNavBarEvent>((event, emit) async{
      if(event is BottomNavBarChangePageEvent){
        emit(BottomNavBarLoadedState(event.pageIndex));
      }
    });
  }
}
