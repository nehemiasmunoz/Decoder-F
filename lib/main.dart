import 'package:decoder/routes/app_routes.dart';
import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:decoder/src/data/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GeminiProvider>(
            create: (ctx) => GeminiProvider()),
        ChangeNotifierProvider<IngredientDatabaseProvider>(
            create: (ctx) => IngredientDatabaseProvider()),
        ChangeNotifierProvider<UserForm>(create: (ctx) => UserForm()),
        ChangeNotifierProvider<UserDatabaseProvider>(
            create: (ctx) => UserDatabaseProvider()),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
