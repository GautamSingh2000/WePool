import 'package:wepool/utils/constants.dart';

class DeviceInfoModel {
  final String deviceId;
  final String deviceType;
  final String deviceName;

  DeviceInfoModel({
    required this.deviceId,
    required this.deviceType,
    required this.deviceName,
  });

  // Convert to Map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      AppConstants.DEVICE_ID: deviceId,
      AppConstants.DEVICE_TYPE: deviceType,
      AppConstants.DEVICE_NAME: deviceName,
    };
  }

  // Create object from Map
  factory DeviceInfoModel.fromMap(Map<dynamic, dynamic> map) {
    return DeviceInfoModel(
      deviceId: map[AppConstants.DEVICE_ID] ?? '',
      deviceType: map[AppConstants.DEVICE_TYPE] ?? '',
      deviceName: map[AppConstants.DEVICE_NAME] ?? '',
    );
  }
}
