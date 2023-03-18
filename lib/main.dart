import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/provider/connectivity.dart';
import 'package:provider_example/provider/counter.dart';
import 'package:provider_example/routes/app_routes.dart';
import 'package:provider_example/screens/home.dart';
import 'package:provider_example/screens/no_internet.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CounterProvider(context, 1),
      ),
      ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<ConnectivityResult>(
          stream: Provider.of<ConnectivityProvider>(context).connectivityStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (isNetworkAvailable(snapshot)) {
                return const _Unfocus(child: HomeScreen());
              } else {
                return const NoInternetScreen();
              }
            } else {
              return const NoInternetScreen();
            }
          }),
    );
  }

  bool isNetworkAvailable(AsyncSnapshot<ConnectivityResult> snapshot) {
    return snapshot.data == ConnectivityResult.mobile ||
        snapshot.data == ConnectivityResult.wifi;
    // || snapshot.data == ConnectivityResult.vpn ||
    // snapshot.data == ConnectivityResult.ethernet;
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
