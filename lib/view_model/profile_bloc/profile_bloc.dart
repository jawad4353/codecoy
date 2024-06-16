import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../main.dart';
import '../../model/user_model.dart';
import '../../utilis/app_preferences.dart';
part 'profile_bloc_events.dart';
part 'profile_bloc_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStates> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) async{
      if(event is ProfileLoadEvent){
        emit(ProfileLoadingState());
        try{
          DocumentSnapshot<Map<String, dynamic>> profileData= await FirebaseFirestore.instance.collection('users').doc(preferences.getString(AppPrefs.keyEmail)).get();
          if(profileData.exists){
            UserModel ? myModel=UserModel.fromJson(json.decode(profileData.data().toString()??''));
            print(myModel.name);
            EasyLoading.show(status: myModel.name);

          }

        }
        catch(e){
          EasyLoading.showError(e.toString());
        }

      }

    });
  }
}
