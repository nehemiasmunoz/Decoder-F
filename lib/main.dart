import 'package:decoder/routes/app_routes.dart';
import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserForm>(create: (ctx) => UserForm()),
        ChangeNotifierProvider<UserDatabaseProvider>(
            create: (ctx) => UserDatabaseProvider()),
      ],
      child: MaterialApp(
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
