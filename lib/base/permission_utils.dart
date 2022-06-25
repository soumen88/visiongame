import 'package:permission_handler/permission_handler.dart';

class PermissionUtils{
  Future<bool> askMicroPhonePermission() async{
    bool isPermissionAvailable = false;
    var status = await Permission.microphone.status;
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
}