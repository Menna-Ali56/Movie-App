import 'package:flutter/material.dart';

import 'ui/screens/Auth/login/login_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login_screen,
      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.login_screen:(context)=> LoginScreen(),
      }
      ,
    );
  }
}