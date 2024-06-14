import 'package:flutter/material.dart';
import 'app_fonts.dart';


class AppTextStyles{

  static montserrato({required Color color,required fontSize,required FontWeight weight,}){
return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily:AppFontFamilies.montserrat );
}

  static roboto({required Color color,required fontSize,required FontWeight weight,}){
    return TextStyle(height: 1,color: color,fontWeight: weight,fontSize: fontSize,fontFamily:AppFontFamilies.roboto );
  }


}