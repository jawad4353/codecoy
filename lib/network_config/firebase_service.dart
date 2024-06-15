import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      EasyLoading.show(status: 'Registering...');
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
        });
      }

      EasyLoading.showSuccess('Registration successful!');
      return user;
    } catch (e) {
      EasyLoading.showError('Registration failed: $e');
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
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

  Future<bool> updatePassword(String newPassword) async {
    try {
      EasyLoading.show(status: 'Updating password...');
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        await _firestore.collection('users').doc(user.email).update({'password': newPassword});
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
        apiKey: "BAGtcwqcLu2GgsZ_QTbbgHqedaBbqOQmfLcSKuTIZmydST",
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
