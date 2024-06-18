
import 'package:codecoy/utilis/app_constants.dart';
import 'package:codecoy/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../view_model/live_tracking_bloc/live_tracking_bloc.dart';

class LiveTrackingMap extends StatefulWidget {
  const LiveTrackingMap({super.key});
  @override
  State<LiveTrackingMap> createState() => _LiveTrackingMapState();
}

class _LiveTrackingMapState extends State<LiveTrackingMap> {
  // Location _location = Location();

  @override
  void initState() {
    super.initState();
    // _location.onLocationChanged.listen((LocationData currentLocation) {
    //   final currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //   add(LocationChangedEvent(currentPosition));
    // });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: myAppBar(title: AppConstants.liveTrack, context: context,shouldPop: false)),
      body: BlocBuilder<LiveTrackingBloc, LiveTrackingState>(
        builder: (context, state) {
          if (state is LiveTrackingInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LiveTrackingLoadedState) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: state.currentPosition,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                // You can optionally save the controller here if needed
              },
            );
          } else {
            return Center(child: Text(AppConstants.errorLoadingMap));
          }
        },
      ),
    );
  }
}