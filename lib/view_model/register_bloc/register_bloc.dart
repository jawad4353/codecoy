import 'package:bloc/bloc.dart';
import 'package:codecoy/main.dart';
import 'package:codecoy/utilis/app_preferences.dart';
import 'package:codecoy/view/screens/bottom_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../network_config/firebase_service.dart';
import '../../utilis/app_routes.dart';
import '../../view/auth/otp_verify.dart';
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
          EasyLoading.show(status: 'Sending  code');
          preferences.setString(AppPrefs.keyEmail, user.email.toString());
          preferences.setString(AppPrefs.keyPassword, event.password);
          preferences.setString(AppPrefs.keyId, user.uid);
          preferences.setString(AppPrefs.keyName, event.name);
          bool isSent=await FirebaseAuthService.sendEmail(user.email.toString(),event.name);
          emit(RegisterErrorState());
          if(isSent){
            Navigator.pushReplacement(event.context, MyRoute(const VerifyOTP()));
          }

        }
       }



      if(event is RegisterVerifyEmailEvent){
        emit(RegisterVerifyingState());
        bool isUpdated =await FirebaseAuthService.updateVerificationStatus('verified');
        if(isUpdated){
          emit(RegisterVerifiedState());
          preferences.setBool(AppPrefs.keyIsLogin, true);
          Navigator.pushReplacement(event.context, MyRoute(const BottomScreen()));
        }
        else{
          emit(RegisterErrorState());
        }
      }

    });
  }
}
