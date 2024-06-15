import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codecoy/network_config/network_config.dart';
import 'package:codecoy/utilis/app_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<User?> registerWithEmailAndPassword({required String name,required String email
    ,required String password }) async {
    try {
      EasyLoading.show(status: 'Registering...');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      await user?.updateDisplayName(name);
      await user?.reload();
      user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(email).set({
          'name': name,
          'email': email,
          'uid': user.uid,
          'imageUrl': 'noimage',
          'password': password,
          'isVerified':'unverified'
        });
      }
      //EasyLoading.showSuccess('Registration successful!');
      return user;
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(e.toString().split(']')[1]);
      return null;
    } finally {

      EasyLoading.dismiss();

    }
  }


  static Future<bool> sendEmail(String email,String name) async {
    bool result=false;
    String serviceID='service_j7ma9pr',
        templateID='template_3lz8e4d',
        userID='BoYM08f7qBuOljP4H';
    String code="${Random().nextInt(3000)+Random().nextInt(2000)+100}";
    try {
         preferences.setString(AppPrefs.keyOtp, code);
      ApiResponse myResponse = await NetworkConfig.postApiCall(
          'https://api.emailjs.com/api/v1.0/email/send', {
        'service_id': serviceID,
        'user_id': userID,
        'accessToken':'f7wxo1XWw1sTP2R6chWQ-',
        'template_id': templateID,
        'template_params': {
          'name': name,
          'receiver_email': email,
          'OTP': code,
        }
      });
      if(myResponse.done??false){
        result=true;
        EasyLoading.showSuccess('Code sent');
      }
      else{
        EasyLoading.showInfo('Email code not sent');
        await _firestore.collection('users').doc(_auth.currentUser?.email??'').delete();
        await _auth.currentUser!.delete();
        print('here');
      }
    }
    catch(e){
      EasyLoading.showInfo('Email code not sent');
      await _firestore.collection('users').doc(_auth.currentUser?.email??'').delete();
      await _auth.currentUser!.delete();
      print('here');

    }

  return result;
  }






  //static Future<bool> sendEmail(String email,String name) async {
   // await _auth.signInWithEmailLink(email: email, emailLink: '').whenComplete(() => print('emailed sent'));
    // final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendEmail');
    // bool result=false;
    // String code="${Random().nextInt(3000)+Random().nextInt(2000)+100}";
    //
    // try {
    //   preferences.setString(AppPrefs.keyOtp, code);
    //   EasyLoading.show(status: 'Sending code to $email');
    //   await callable.call(<String, dynamic>{
    //     'email': email,
    //     'subject': 'OTP Verification',
    //     'text': ""
    //         "Hi $name"
    //         ""
    //         "Your OTP code for the Codecoy app is:   $code "
    //         ""
    //         "Good Luck"
    //         "Team CodeCoy",
    //   });
    //   EasyLoading.showSuccess('Code sent');
    //   result=true;
    //
    // } catch (e) {
    //   print('Error sending email: $e');
    //   EasyLoading.showError(e.toString());
    // }
   //  return result;
 // }




  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      EasyLoading.show(status: 'Signing in...');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      EasyLoading.showSuccess('Sign-in successful!');
      return userCredential.user;
    } catch (e) {
      EasyLoading.showError('Sign-in failed: $e');
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<bool> updateVerificationStatus(String status) async {
    bool updated=false;
    try {
      EasyLoading.show(status: 'progressing...');
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.email).update(
            {'isVerified': status});
        EasyLoading.showSuccess('Verified successfully!');
        return true;
      }
      EasyLoading.showError('Something went wrong');
      updated=true;
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
    return updated;
  }

  Future<bool> updatePassword(String newPassword) async {
    try {
      EasyLoading.show(status: 'Updating password...');
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        await _firestore.collection('users').doc(user.email).update(
            {'password': newPassword});
        EasyLoading.showSuccess('Password updated successfully!');
        return true;
      }
      EasyLoading.showError('No user found.');
      return false;
    } catch (e) {
      EasyLoading.showError('Password update failed: $e');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signOut() async {
    try {
      EasyLoading.show(status: 'Signing out...');
      await _auth.signOut();
      EasyLoading.showSuccess('Sign-out successful!');
    } catch (e) {
      EasyLoading.showError('Sign-out failed: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDvucuzUkiSI6_W2uFCUXoYGvwkoYtjK3s",
        appId: "1:268459879851:android:5b3867c3ef984e2bb036ee",
        messagingSenderId: '268459879851',
        projectId: "codecoy-5d6fa",
        storageBucket: 'codecoy-5d6fa.appspot.com',
      ),
    );
  }


  static Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
