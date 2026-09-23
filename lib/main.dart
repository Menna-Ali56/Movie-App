import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/screens/Auth/register/register_screen.dart';
import 'package:movie_app/ui/screens/Auth/reset_password/reset_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'ui/screens/Auth/login/login_screen.dart';

import 'package:movie_app/ui/screens/home/tabs/profile_tab.dart';
import 'package:movie_app/ui/screens/home/tabs/update_profile/update_profile.dart';
import 'package:movie_app/ui/screens/home/widgets/bottom_bar.dart';


import 'ui/screens/home/tabs/home_screen.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.onboarding,

      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login_screen: (context) => LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.register_screen: (context) => RegisterScreen(),
        AppRoutes.reset_password: (context) => const ResetPassword(),

        AppRoutes.bottom_bar: (context) => const BottomBar(),
        AppRoutes.update_profile: (context) => const UpdateProfile(),
        AppRoutes.profile_tab: (context) => const ProfileTab(),
      },
    );
  }
}
