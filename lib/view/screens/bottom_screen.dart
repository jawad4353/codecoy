
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:codecoy/view/screens/live_tracking/live_track.dart';
import 'package:codecoy/view/screens/profile/profile.dart';
import 'package:codecoy/view/screens/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utilis/app_colors.dart';
import '../dialogues/exit_dialogue.dart';
import 'home/home.dart';



class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  var listScreens = [const Home(),const Weather(),const ProfileScreen(),const LiveTracking(),];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {  bool result= await onExit(context);
        return result;

        } ,
        child:  Scaffold(
          body: listScreens[i],
          bottomNavigationBar: BottomBarCreative(
            color:Colors.black.withOpacity(0.7) ,
            indexSelected: i,
            items:  const [
              TabItem(icon: FontAwesomeIcons.home,title: 'Home',),
              TabItem(icon:FontAwesomeIcons.cloudArrowDown,title: 'Weather'),
              TabItem(icon:FontAwesomeIcons.solidUser,title: 'Profile'),
              TabItem(icon: FontAwesomeIcons.city,title: 'Track'),

            ],
            titleStyle: const TextStyle(fontSize: 13),
            isFloating: true,
            highlightStyle: HighlightStyle(
              isHexagon: true,
              background: AppColors.primary,
            ),
            backgroundColor: Colors.white,
            colorSelected: AppColors.primary,
            onTap: (a){
              print(a);
              setState(() {
                i=a;
              });
            },
          ),
        ));
  }
}
