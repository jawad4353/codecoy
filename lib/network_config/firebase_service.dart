import 'package:cloud_firestore/cloud_firestore.dart';
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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      userCredential.user!.sendEmailVerification();
      await user?.updateDisplayName(name);
      await user?.reload();
      user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(email).set({
          'name': name,
          'email': email,
          'uid': user.uid,
          'imageUrl': 'noimage',
        });
      }
      EasyLoading.showSuccess('Verify your email by clicking link sent at $email');
      return user;
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(e.toString().split(']')[1]);
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }




  static Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential;
    try {
      EasyLoading.show(status: 'Signing in...');
       userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!=null) {
       if( userCredential.user!.emailVerified){
         EasyLoading.showSuccess('Sign-in successful!');
         return userCredential.user;
       }else{
         await userCredential.user!.sendEmailVerification();
         EasyLoading.showSuccess('Verify you email by clicking the link sent at ${userCredential.user!.email}');
         return null;
       }
      } else {
        return null;
      }
    } catch (e) {
      EasyLoading.showError(e.toString().split(']')[1]);
      return null;
    }
  }


  static Future<bool> resetPassword(String email) async {
    try {
       await _auth.sendPasswordResetEmail(email: email);
       EasyLoading.showSuccess('Password reset link sent');
       return true;
    } catch (e) {
     EasyLoading.showError(e.toString().split(']')[1]);
     return false;
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
