

import 'package:codecoy/main.dart';
import 'package:flutter/services.dart';

class AppConstants{
  static String logIn='Log IN ';
//Login
  static String login='Login';
  static String welcomeBack='Welcome Back';
  static String moveMate='Movemate';
  static String enterUsernamePassword='Enter your Email & Password';
  static String alreadyHaveAccount='Already have an account? ';
  static String name='Name';
  static String nameHint='Jawad';
  static String email='Email';
  static String emailHint='abc@gmail.com';
  static String password='Password';
  static String passwordHint='●●●●●●';
  static String rememberMe='Remember Me';
  static String forgotPassword='Forgot Password ?';
  static FilteringTextInputFormatter emailFormatter=passwordFormatter;
  static FilteringTextInputFormatter passwordFormatter= FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_\-@.]*$'));
  static FilteringTextInputFormatter nameFormatter=FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z - ]'));
 //boarding
  static String boardingTitle='"Unified Teamwork Platform"';
  static String boardingSubtitle='Boost productivity with clear communication and integrated tools for'
      ' a smooth, efficient, and streamlined workflow';
  static String skip='Skip';
  static String next='Next';
  //Register
  static String signUp='Sign Up';
  static String code='Code';
  static String enterRealInformation='Enter your information';

  static String confirmPassword='Confirm Password';
  static String phoneNumber='Phone  Number';
  static String session='Session';
  static String dontHaveAccount='Didn’t have an account? ';

//get otp forgetpassword screen
  static String forgetPassword='Forget Password';
  static String enterEmail='Enter email to get otp';
  static String getLink='Get Email Link';

  //home
  static String contactUs='Contact Us';
  static String shareApp='Share App';
  static String aboutUs='About Us';
  static String logOut='Logout';
  static String contactUsUrl='https://codecoytechnologies.com/contact/';
  static String aboutUsUrl='https://codecoytechnologies.com/about/';
  static String shareAppUrl='https://drive.google.com/file/d/1xlWseTSDabQTf7m6bFieiDdjosFyDt_b/view?usp=sharing';
  static String appVersion='version $version';

}