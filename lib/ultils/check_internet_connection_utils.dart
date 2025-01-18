import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetConnectionUtils {
  static Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.none);
  }
}
