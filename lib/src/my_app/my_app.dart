import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/core/route/app_router.dart';
import 'package:flutter_riverpod_template/core/util/app_color.dart';
import 'package:flutter_riverpod_template/core/util/app_service.dart';
import 'package:flutter_riverpod_template/src/splash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      child: MaterialApp(
        key: AppService.appKey,
        navigatorKey: AppService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColor.green900,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
      scaffoldBackgroundColor: brightness == Brightness.light
          ? AppColor.kScaffold
          : AppColor.kBackgroundDarkColor,
    );
  }
}
