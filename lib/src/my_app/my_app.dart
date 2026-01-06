import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/core/route/app_router.dart';
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
        theme: ThemeData(
          primaryColor: const Color(0xFF5956E9),
          primaryColorLight: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
