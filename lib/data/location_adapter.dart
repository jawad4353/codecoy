import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Location extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  double longitude;

  Location(this.name, this.latitude, this.longitude);
}