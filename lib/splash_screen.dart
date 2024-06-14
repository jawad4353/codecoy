import 'package:codecoy/utilis/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState(){
    super.initState();
   // Timer(const Duration(seconds: 3,),()=>Navigator.pushReplacement(context, MyRoute(const BoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: 400,color: AppColors.black,),
    );
  }
}
