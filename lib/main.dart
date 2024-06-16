import 'dart:async';
import 'package:codecoy/network_config/firebase_service.dart';
import 'package:codecoy/splash_screen.dart';
import 'package:codecoy/utilis/app_colors.dart';
import 'package:codecoy/view/screens/home/notifications.dart';
import 'package:codecoy/view_model/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:codecoy/view_model/login_bloc/login_bloc.dart';
import 'package:codecoy/view_model/profile_bloc/profile_bloc.dart';
import 'package:codecoy/view_model/register_bloc/register_bloc.dart';
import 'package:codecoy/view_model/web_view_bloc/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/hive-helper.dart';


late SharedPreferences preferences;
String ? version;
NotificationService notificationService = NotificationService();
String ? bearerToken;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.init();
  notificationService.initialize();
  notificationService.initializeWorkManager();
  FirebaseAuthService.initialize();
  FirebaseAuthService.getAppVersion();
  preferences=await SharedPreferences.getInstance();
  runApp( MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:AppColors.primary
  ));
}
//free api key    AIzaSyBJ_XlxltqRMHEaqUxKak6LkIb0jt4qRWM

class MyApp extends StatelessWidget {
  Size ? size;
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize:  Size(size!.width, size!.height),
      child: MultiBlocProvider(
        providers: [
         BlocProvider(create: (context)=>WebViewBloc()),
          BlocProvider(create: (context)=>RegisterBloc()),
          BlocProvider(create: (context)=>LoginBloc()),
          BlocProvider(create: (context)=>BottomNavBarBloc()),
          BlocProvider(create: (context)=>ProfileBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
