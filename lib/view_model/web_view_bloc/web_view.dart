import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'web_view._event.dart';
part 'web_view._state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(WebViewInitialState()) {
    on<WebViewEvent>((event, emit) async{
      if(event is WebViewLoadingEvent){
      emit(WebViewLoadingState());
      }
      if(event is WebViewLoadedEvent){
        emit(WebViewLoadedState());
      }
      if(event is WebViewErrorEvent){
        emit(WebViewErrorState());
      }

    });
  }
}
