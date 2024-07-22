import 'package:decoder/src/ui/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = "home";

  static Map<String, Widget Function(BuildContext)> routes = {
    "home": (BuildContext context) => const HomeScreen(),
    "detail": (BuildContext context) => const DetailScreen()
  };
}
