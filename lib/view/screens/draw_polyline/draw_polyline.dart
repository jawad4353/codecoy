import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_constants.dart';
import '../../widgets/custom_appbar.dart';

class DrawPolyLine extends StatefulWidget {
  const DrawPolyLine({super.key});

  @override
  State<DrawPolyLine> createState() => _DrawPolyLineState();
}

class _DrawPolyLineState extends State<DrawPolyLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0.h),
          child: myAppBar(title: AppConstants.drawPolyline, context: context, shouldPop: false)),
    );
  }
}
