import 'package:e_shelter/providers/navigation_bar_provider.dart';
import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'firebase_options.dart';
import 'routes/route.dart' as route;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserInfoProvider()),
    ListenableProxyProvider<UserInfoProvider, NavigationBarProvider>(
      update: (_, userInfo, __) =>
          NavigationBarProvider(userInfo.userInfo["userType"] != "" ? 1 : 0),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // code that is setting the first page you will see when you open your app
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
      theme: Themes.darkTheme,
      // home: const HomeWidget()
    );
  }
}
