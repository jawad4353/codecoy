import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
    } catch (e) {
      print(e);
    }
  }
  static Future<Box?> openBox({required String name}) async {
    try {
      return await Hive.openBox(name);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> putData({required String boxName, required String key, required dynamic data}) async {
    try {
      var box = await openBox(name: boxName);
      if (box != null) {
        await box.put(key, data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> deleteDatabase() async {
    try {
      await Hive.deleteFromDisk();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
