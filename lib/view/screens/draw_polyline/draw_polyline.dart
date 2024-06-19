import 'package:codecoy/view/widgets/custom_button.dart';
import 'package:codecoy/view/widgets/custom_text_field.dart';
import 'package:codecoy/view_model/draw_polyline_bloc/draw_polyline_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_images.dart';
import '../../widgets/custom_appbar.dart';

class DrawPolyLine extends StatefulWidget {
  const DrawPolyLine({super.key});

  @override
  State<DrawPolyLine> createState() => _DrawPolyLineState();
}

class _DrawPolyLineState extends State<DrawPolyLine> {
  TextEditingController destinationLatitude = TextEditingController();
  TextEditingController destinationLongitude = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DrawPolyLineBloc>().add(FetchLocationEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: myAppBar(
              title: AppConstants.drawPolyline,
              context: context,
              shouldPop: false)),
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
          ),
          BlocBuilder<DrawPolyLineBloc, DrawPolyLineState>(
            builder: (context, state) {
              if (state is DrawPolyLineLoadedState) {
                return SizedBox(
                    height: 1.sh,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController controller) {},
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          state.currentPosition.latitude ?? 0.0,
                          state.currentPosition.longitude ?? 0.0,
                        ),
                        zoom: 15,
                      ),
                      markers: <Marker>{
                        Marker(
                          markerId: const MarkerId("current_location"),
                          position: LatLng(
                            state.currentPosition.latitude ?? 0.0,
                            state.currentPosition.longitude ?? 0.0,
                          ),
                          infoWindow: const InfoWindow(
                            title: "My Location",
                          ),
                        ),
                      },
                    ));
              } else if (state is DrawPolyLineErrorState) {
                return Center(child: Text(state.message));
              }
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            },
          ),
          Positioned(
            top: 10.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.sw*0.2),
              color: AppColors.white,
              child: Column(
                children: [
                  customTextField(
                      controller: destinationLatitude,
                      hintText: AppConstants.latitudeHint,
                      title: AppConstants.latitude,
                      icon: AppImages.longitudeLatitudeIcon,
                      isPasswordField: false,
                      inputFormatter: AppConstants.longitudeLatitudeFormatter),
                  SizedBox(height: 5.h,),
                  customTextField(
                      controller: destinationLatitude,
                      hintText: AppConstants.longitudeHint,
                      title: AppConstants.longitude,
                      icon: AppImages.longitudeLatitudeIcon,
                      isPasswordField: false,
                      inputFormatter: AppConstants.longitudeLatitudeFormatter),
                  SizedBox(height: 5.h,),
                  customButton(title: AppConstants.drawPolyline, onPressed: (){})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
