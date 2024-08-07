import 'package:decoder/src/presentation/ui/screens/screens.dart';
import 'package:decoder/src/presentation/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = "splash";
  static final Map<String, Widget Function(BuildContext)> routes = {
    "splash": (BuildContext _) => const SplashScreen(),
    "home": (BuildContext context) => const HomeScreen(),
    "detail": (BuildContext context) => const DetailScreen(),
    "register": (ctx) => const UserRegisterScreen(),
  };
}
