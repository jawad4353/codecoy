import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../network_config/firebase_service.dart';
import '../../utilis/app_routes.dart';
import '../../view/auth/login.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserEvent>((event, emit) async{
      if(event is RegisterUserEventApi){
        emit(RegisterLoadingState());
        User ? user= await FirebaseAuthService.registerWithEmailAndPassword(name: event.name, email: event.email, password: event.password);
       print('user is $user');
        if(user==null){
          emit(RegisterErrorState());
        }
        else {
          emit(RegisterSuccessfulState());
          Navigator.pushReplacement(event.context, MyRoute(Login()));

        }
       }

    });
  }
}
