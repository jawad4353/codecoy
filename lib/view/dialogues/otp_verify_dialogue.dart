import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../main.dart';
import '../../network_config/network_config.dart';
import '../../network_config/api_params.dart';
import '../../network_config/api_urls.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_preferences.dart';
import '../../utilis/app_text_styles.dart';

class OTPDialog extends StatelessWidget {
  String email;
  OTPDialog(this.email, {super.key, });
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 22.h),
            Text(AppConstants.verifyCode,style: AppTextStyles.robotoBoldItalic(color: AppColors.grey0E0F10, fontSize: 22.sp, weight: FontWeight.bold),),
            SizedBox(height: 10.h),
            Text(AppConstants.enterOtpCodeSent,style: AppTextStyles.robotoBoldItalic(color: AppColors.grey0E0F10, fontSize: 14.sp, weight: FontWeight.w500),),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Pinput(
                length: 6,
                onCompleted: (a){verifyUser(context);},
                controller: _pinPutController,
                defaultPinTheme: PinTheme(
                  height: 48.h,
                  width: 68.h,
                  textStyle: AppTextStyles.robotoMedium(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    weight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.white,
                  ),
                ),
                focusedPinTheme: PinTheme(
                  height: 48.h,
                  width: 68.h,
                  textStyle: AppTextStyles.robotoMedium(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    weight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            SizedBox(
              height: 48.h,
              width: double.maxFinite,
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r)
                      )
                  ) ,
                  onPressed: (){
                    if(_pinPutController.length==5){
                      verifyUser(context);
                    }


                  }, child:Text(AppConstants.verify,style: AppTextStyles.robotoBold(color: AppColors.black, fontSize: 16.sp, weight: FontWeight.w600),) ),
            ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }

  Future<void> verifyUser(context) async {
    try{
      EasyLoading.show(status: 'verifying');

      ApiResponse response=await NetworkConfig.postApiCall(ApiUrls.baseUrl+ApiUrls.apiVerifyUser, {Params.code:_pinPutController.text,Params.email:email});
      print(response.responseString);
      if(response.done??false){
        Map map=json.decode(response.responseString??'');
        preferences.setString(AppPrefs.keyToken, map['token']);
        if(map['success']==true){
          EasyLoading.dismiss();
        // Navigator.pushReplacement(context, MyRoute(const ResetPassword()));
        }
        else{
          EasyLoading.showSuccess(map['message']);
        }
      }
      else{
        EasyLoading.showError(response.errorMsg??'');
      }
    }
    catch(e){
      EasyLoading.showError(e.toString());
    }
  }
}
