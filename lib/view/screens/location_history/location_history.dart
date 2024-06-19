import 'package:codecoy/utilis/app_constants.dart';
import 'package:codecoy/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_text_styles.dart';

class LocationHistory extends StatefulWidget {
  const LocationHistory({super.key});
  @override
  State<LocationHistory> createState() => _LocationHistoryState();
}

class _LocationHistoryState extends State<LocationHistory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0.sp),
          child: myAppBar(title: AppConstants.locationHistory, context: context, shouldPop: false)),
      body: Text(''),
    );
  }



  Widget locationCard({required Color color,required String stopId,required String  stopName,required String lat,required String lng  }){
    return Container(
      height: 110,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow:  [BoxShadow(color: AppColors.grey0E0F10.withOpacity(0.1),spreadRadius: 1.1,blurRadius: 0.5)]
      ),
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 3),
      child: Row(
        children: [
          Container(
            width: 7,
            decoration: BoxDecoration(
                color: color.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25)
            ),
          ),

          Stack(
            children: [
              SizedBox(height: 110, width:1.sw*0.95),
              Positioned(
                  left: 10,
                  top: 16,
                  child: Wrap(
                    children: [
                      Text('',style: AppTextStyles.robotoMedium(color: color, fontSize: 15.0.sp, weight: FontWeight.w500),),
                      const SizedBox(width: 3.0,),
                      Text(stopName.toUpperCase(),style: AppTextStyles.robotoMedium(fontSize: 15.sp, weight: FontWeight.w500,color:  AppColors.primary),),
                    ],
                  )),


              Positioned(
                bottom: 10,
                left: 8,
                child: Column(children: [
                  Text(AppConstants.longitude.toUpperCase(),style: AppTextStyles.robotoMedium(color: color, fontSize: 15.0, weight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Text(lat.substring(0,6),style: AppTextStyles.robotoMedium(fontSize: 16.0, weight: FontWeight.w500,color:  AppColors.grey0E0F10.withOpacity(0.8)),)
                ],),
              )
              ,
              Positioned(
                bottom: 10,
                right: 8,
                child: Column(children: [
                  Text(AppConstants.latitude.toUpperCase(),style: AppTextStyles.robotoMedium(color: color, fontSize: 15.0, weight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Padding(
                    padding:  const EdgeInsets.only(top: 3),
                    child: Text(lng.substring(0,6),style: AppTextStyles.robotoMedium(fontSize: 15.0, weight: FontWeight.w500,color:  AppColors.grey0E0F10.withOpacity(0.8)),),
                  )
                ],),
              )
            ],
          )
        ],),
    );
  }

}