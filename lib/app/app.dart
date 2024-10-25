import 'package:crafty_bay/app/theme/app_themes.dart';
import 'package:crafty_bay/app/routes/app_routes.dart';
import 'package:crafty_bay/bindings/app_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBayApp.navigatorKey,
      getPages: AppRoutes.appRoutes(),
      initialBinding: AppBindings(),
      theme: AppThemes.lightThemeData(context),
      darkTheme: AppThemes.darkThemeData(context),
      themeMode: ThemeMode.system,
    );
  }
}
