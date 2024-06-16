import 'package:codecoy/view_model/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_images.dart';
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
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileLoadEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor:AppColors.primary ,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text(AppConstants.profile,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 24.sp, weight: FontWeight.w600),),),
        body:  BlocBuilder<ProfileBloc,ProfileStates>(
          builder: (context,state) {
            if(state is ProfileLoadingState){
              return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
            }
            if(state is ProfileLoadedState){
              return  _body(name: '', designation: '', userId: '', registrationDate: '', email: '');
            }
            if(state is ProfileErrorState){
              EasyLoading.showInfo('Something went wrong');
              return   _body(name: '_', designation: '_', userId: '_', registrationDate: '_', email: '_');
            }
            return const SizedBox();
          }
        )
    );
  }


  Widget _body({required String name,required String designation,required String userId,required String registrationDate,required String email,}){
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 15.h,),
          _userImage(),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 45.h),
            child: Text(name, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: AppColors.black191B32),),
          ),
          SizedBox(height: 1.h,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.2.sw),
            child: Text(designation, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: AppColors.black191B32),),
          ),
          SizedBox(height: 20.h,),
          _detailBox(email: email, userId: userId, registrationDate: registrationDate)
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

  Widget _detailBox({required String userId,required String registrationDate,required String email,}){
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
          _titleValue(title: AppConstants.userID, value: userId),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color: AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title:AppConstants.email, value: email ),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color:  AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title: AppConstants.registrationDate, value: registrationDate),
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



