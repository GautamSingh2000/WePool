import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:wepool/utils/constants.dart';

import '../data/models/DeviceInfoModel.dart';

class HiveHelper {
  static late Box _box; // Single instance of Hive Box
  // Private constructor to prevent instantiation
  HiveHelper._();

  // Initialize Hive Box (call this once in `main.dart`)
  static Future<void> init() async {
    _box = await Hive.openBox(AppConstants.APP_HIVE_BOX);
  }

  // Get the box instance safely
  static Box get box {
    if (!_box.isOpen) {
      throw Exception(
        "Hive box is not initialized. Call HiveHelper.init() first.",
      );
    }
    return _box;
  }

  // Save Device Info
  static void saveDeviceInfo(DeviceInfoModel deviceInfo) {
    _box.put(AppConstants.DEVICE_INFO, deviceInfo.toMap());
  }

  // Retrieve Device Info
  static DeviceInfoModel getDeviceInfo() {
    print("fetching all data ");
      var data = _box.get(AppConstants.DEVICE_INFO);
    print("fetching all data $data");
      return DeviceInfoModel.fromMap(data);
  }

  // Save data
  static void saveData(String key, dynamic value) {
    _box.put(key, value);
  }

  // Retrieve data
  static dynamic getData(String key) {
    return _box.get(key);
  }

  static bool getBoolData(String key){
    return _box.get(key,defaultValue: false);
  }

  // Delete data
  static void deleteData(String key) {
    _box.delete(key);
  }
}
