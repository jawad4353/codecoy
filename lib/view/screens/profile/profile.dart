import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_images.dart';
import '../../../utilis/app_preferences.dart';
import '../../../utilis/app_text_styles.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // File _image = File("");
  // final picker = ImagePicker();
  String ? imageUrl;
  String ? version ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor:AppColors.primary ,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text('Profile',style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 24.sp, weight: FontWeight.w600),),),
        body:  _body()
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 15.h,),
          _userImage(),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 45.h),
            child: Text(preferences.getString(AppPrefs.keyName)??'', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: AppColors.black191B32),),
          ),
          SizedBox(height: 1.h,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.2.sw),
            child: Text('', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: AppColors.black191B32),),
          ),
          SizedBox(height: 20.h,),
          _detailBox()
        ],
      ),
    );
  }


  Widget _userImage(){
    return Center(
      child: Stack(
        children: [
          Container(
            height: 135.h,
            width: 135.h,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 5),
                shape: BoxShape.circle
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 6),
                shape: BoxShape.circle,
              ),

              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 6),
                    shape: BoxShape.circle,
                    image:0==1 ?  DecorationImage(image:  Image.asset(imageUrl??'',).image, fit: BoxFit.cover)
                        : DecorationImage(image: Image.asset(AppImages.imgProfile).image, fit: BoxFit.cover)
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0.0,
              right: 5.w,
              child: GestureDetector(
                  onTap: (){
                  },
                  child: const Icon(Icons.edit)))
        ],
      ),
    );
  }

  Widget _detailBox(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary.withOpacity(0.1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleValue(title: "", value: preferences.getString(AppPrefs.keyId) ?? ''),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color: AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title: "ID", value: "_" ),
          SizedBox(height: 15.h,),
          _titleValue(title: "Email", value: "_" ),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color:  AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title: "Registration date", value: ''),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color:  AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),

        ],
      ),
    );
  }


  Widget _titleValue({title, value}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 16.sp, weight: FontWeight.w500)),
        SizedBox(height: 7.h,),
        Text(value, style:AppTextStyles.robotoMedium(color: AppColors.primary, fontSize: 15.sp, weight: FontWeight.w500)),
      ],
    );
  }



}



