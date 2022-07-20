import 'package:blue_thermal_printer/blue_thermal_printer.dart';
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
      ].request();
    }

    isPermissionAvailable =  !status.isDenied;
    return Future.value(isPermissionAvailable);
  }


  Future<bool?> isBluetoothOn() async{
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    bool? isConnected = await bluetooth.isConnected;
    _logger.log(_TAG, "Bluetooth $isConnected");
    return Future.value(isConnected);
  }
}