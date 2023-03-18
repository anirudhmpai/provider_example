import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider_example/provider/base.dart';

class ConnectivityProvider extends BaseProvider {
  ConnectivityProvider();
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;
}
