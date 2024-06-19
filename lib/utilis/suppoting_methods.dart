
import 'package:geocoding/geocoding.dart';


class SupportingMethods{
  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String formattedAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      return formattedAddress;
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }

}