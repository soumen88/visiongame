import 'package:permission_handler/permission_handler.dart';
import 'package:visiongame/injector/injection.dart';

import 'logger_utils.dart';

class PermissionUtils{

  final _logger = locator<LoggerUtils>();
  final _TAG = "PermissionUtils";

  Future<bool> askMicroPhonePermission() async{
    bool isPermissionAvailable = false;
    var status = await Permission.microphone.status;
    _logger.log(_TAG, "Status denied ${status.isDenied}");
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.bluetooth,
      ].request();
    }

    if (await Permission.microphone.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }

    isPermissionAvailable =  await Permission.microphone.status.isGranted;
    return Future.value(isPermissionAvailable);
  }


  Future<bool> isBluetoothOn() async{
    bool isBluetoothOn = false;
    /*if (await Permission.bl) {
      // Use location.
    }*/
    return Future.value(isBluetoothOn);
  }
}