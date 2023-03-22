import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider_example/helpers/commons.dart';
import 'package:provider_example/provider/base.dart';

class ConnectivityProvider extends BaseProvider {
  late bool _isOnline;
  bool get isOnline => _isOnline;

  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((event) {
      if (Commons.isNetworkAvailable(event)) {
        _isOnline = true;
        notifyListeners();
      } else {
        _isOnline = false;
        notifyListeners();
      }
    });
  }
}
