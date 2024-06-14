import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../main.dart';
import '../../network_config/api_urls.dart';
import '../../network_config/network_config.dart';
import '../../utilis/app_preferences.dart';
import '../../view/dialogues/otp_verify_dialogue.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Map data={};

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if(event is LoginApiEvent){
      try{
        EasyLoading.show(status: 'Signing in');
        ApiResponse response=await NetworkConfig.postApiCall(ApiUrls.baseUrl+ApiUrls.apiLogin, event.map);
       print("${response.responseString} response hh");
        if(response.done??false){
         Map map =json.decode(response.responseString??"");
         if(map['success']==false){
           EasyLoading.showInfo(map['message']);
         }
         else if(map['id']!=null){
           EasyLoading.dismiss();
           //Navigator.push(event.context, MyRoute(const BottomScreen()));
           preferences.setString(AppPrefs.keyToken, map['token']);
           preferences.setString(AppPrefs.keyId, map['id']);
           preferences.setString(AppPrefs.keyEmail, map['email']);
           preferences.setString(AppPrefs.keyPassword, event.map['password']);
           preferences.setBool(AppPrefs.keyRememberMe, event.rememberMe);

         }
       }
       else{
         EasyLoading.showInfo(response.errorMsg??'');
       }

       }
       catch(e){
          //EasyLoading.dismiss();
           EasyLoading.showError(e.toString());
           print(e.toString());
      }
      }


      if(event is ForgetPasswordEvent){
        try{
          EasyLoading.show(status: 'Sending Otp to ${event.email}');
          ApiResponse response=await NetworkConfig.getApiCallWithToken(ApiUrls.baseUrl+ApiUrls.apiForgetPassword+'/${event.email}',);
          print("${response.responseString} response hh");
          if(response.done??false){
            Map map =json.decode(response.responseString??"");
            if(map['success']==false){
              EasyLoading.showInfo(map['message']??'');
              return;
            }
            else{
              EasyLoading.dismiss();

              showDialog(context: event.context, builder: (context)=>OTPDialog(event.email));
            }

          }
          else{
            EasyLoading.showInfo(response.errorMsg??'');
          }

        }
        catch(e){
          //EasyLoading.dismiss();
          EasyLoading.showError(e.toString());
          print(e.toString());
        }
      }
    });
  }
}
