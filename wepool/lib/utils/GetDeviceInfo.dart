import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../data/models/DeviceInfoModel.dart';

Future<DeviceInfoModel> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return DeviceInfoModel(
      deviceId: androidInfo.id,
      deviceType: "Android",
      deviceName: androidInfo.model,
    );
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return DeviceInfoModel(
      deviceId: iosInfo.identifierForVendor ?? '',
      deviceType: "iOS",
      deviceName: iosInfo.name,
    );
  }
  throw Exception("Unsupported Platform");
}

