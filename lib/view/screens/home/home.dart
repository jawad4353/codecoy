import 'package:codecoy/utilis/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../../../main.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_images.dart';
import '../../../utilis/app_preferences.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/app_text_styles.dart';

import '../../auth/login.dart';
import '../../dialogues/logout.dart';
import '../more/change_password.dart';
import '../more/web_view_helper.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Color> myColors=[AppColors.green,AppColors.brown,AppColors.black,AppColors.primary,AppColors.orange,AppColors.purple];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },icon: Image.asset(AppImages.iconDrawer,color: AppColors.primary,height: 38.h,),),
          iconTheme: IconThemeData(color: AppColors.primary,size: 30),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title:Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(27),
                color: AppColors.white,
                boxShadow:  [BoxShadow(color: AppColors.greyB2AFAF,spreadRadius: 0.5)]
            ),
            child: TextField(
              cursorColor: AppColors.primary,
              style:AppTextStyles.robotoMedium(color: AppColors.greyB2AFAF, fontSize: 13.sp, weight: FontWeight.normal),

              onChanged: (a){

              },
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.only(top: 9.h),
                prefixIcon:  Icon(Icons.search,color:  AppColors.greyB2AFAF,),
                hintText: ' Search bus',
                hintStyle: AppTextStyles.robotoMedium(color: AppColors.greyB2AFAF, fontSize: 13.h, weight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ) ,
          actions: [
            IconButton(onPressed: (){

            }, icon:Image.asset(AppImages.iconNotifications,color: AppColors.primary,height: 28.h,)),
          ],
        ),
        drawer:  Drawer(
          backgroundColor: AppColors.white,
          child:  Container(
            color: AppColors.white,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: AppColors.primary ),
                    currentAccountPicture: Container(
                      height: 120.h,
                      width: 120.h,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        image: DecorationImage(image: Image.asset(AppImages.imgProfile).image,fit: BoxFit.cover,),
                      ),
                    ),
                    accountName:  Text(preferences.getString(AppPrefs.keyId)??"",style:AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 18.sp, weight: FontWeight.w600)), accountEmail:  Text(preferences.getString(AppPrefs.keyEmail)??"",style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 16.sp, weight: FontWeight.w400),)),
                _buttons(icon: AppImages.iconPassword,text: AppConstants.changePassword),
                _buttons(icon: AppImages.iconShareApp,text: AppConstants.shareApp),
                _buttons(icon: AppImages.iconAboutUs,text: AppConstants.aboutUs),
                _buttons(icon:AppImages.iconPrivacyPolicy,text:AppConstants.contactUs),
                _buttons(icon: AppImages.iconLogOut,text:AppConstants.logOut ),

                 Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right: 20.h),
                    child: Text(AppConstants.appVersion,style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 15.sp, weight: FontWeight.w300),),
                  ),
                )

              ],
            ),
          ),
        ),

        body: ListView(children:  [
          //const MySlider(),
          Text('\n   Features',style:AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 24.sp, weight: FontWeight.w600),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              valueContainers(title: 'Total Employee', result: '_' , color: AppColors.brown,),
                valueContainers(title: 'Total Flutter', result: '45', color: AppColors.orange,)
              ],),
          ),


        ],),
      ),
    );
  }


  Widget _buttons({required String text,required String icon}) {
    return InkWell(
      onTap: () async {
        if (text == AppConstants.changePassword) {
          Navigator.push(context, MyRoute(const ChangePassword()));
        }
        if (text == AppConstants.shareApp) {
          Share.share(AppConstants.shareAppUrl);
        }
        if (text == AppConstants.aboutUs) {
          Navigator.push(context, MyRoute( WebViewHelper(AppConstants.aboutUsUrl,AppConstants.aboutUs)));
        }
        if (text == AppConstants.contactUs) {
          Navigator.push(context, MyRoute( WebViewHelper(AppConstants.contactUsUrl,AppConstants.contactUs)));
        }
        if (text == AppConstants.logOut) {
          bool s = await onLogOut(context);
          if (s) {
            preferences.remove(AppPrefs.keyId);
            if (preferences.getBool(AppPrefs.keyRememberMe) != true) {
              preferences.remove(AppPrefs.keyEmail);
              preferences.remove(AppPrefs.keyPassword);
            }

            Navigator.pushReplacement(context, MyRoute(const Login()));
          }
        }
      },
      child: Container(
        height: 50,
        color: AppColors.white,
        child: Row(
          children: [
            const SizedBox(width: 10, height: 5,),
            Image.asset(icon, height: 30.h, color: AppColors.primary,),
            const SizedBox(width: 14,),
            Text(text, style: AppTextStyles.robotoMedium(
                color: AppColors.black191B32,
                fontSize: 16.sp,
                weight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }

  Widget valueContainers({required String title, required String result,required Color color}){
    return Container(
      width: 1.sw*0.27 ,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
      decoration: BoxDecoration(
          border: Border.all(color: color , width: 1),
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10,fontSize: 17.0,weight: FontWeight.w500 ),),
          const SizedBox(height: 12),
          Container(
            height: 3,
            width: 22,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(result,style: AppTextStyles.robotoMedium(color: color,fontSize: 20.0,weight: FontWeight.w500 ),)
        ],
      ),
    );
  }


}

