import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/screens/Auth/register/register_screen.dart';
import 'package:movie_app/ui/screens/Auth/reset_password/reset_password.dart';

import 'package:firebase_core/firebase_core.dart';


import 'bloc/language/language_state.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/language/language_bloc.dart';
import 'package:movie_app/bloc/user/user_bloc.dart';

import 'ui/screens/Auth/login/login_screen.dart';

import 'package:movie_app/ui/screens/home/tabs/profile_tab.dart';
import 'package:movie_app/ui/screens/home/tabs/update_profile/update_profile.dart';
import 'package:movie_app/ui/screens/home/widgets/bottom_bar.dart';

import 'ui/screens/home/tabs/home_screen.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    debugPrint("🔥 Firebase initialized successfully");
  } catch (e) {
    debugPrint("🔥 Firebase ERROR: $e");
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale(state.languageCode),
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
            AppRoutes.home: (context) => HomeScreen(),
            AppRoutes.register_screen: (context) => RegisterScreen(),
            AppRoutes.reset_password: (context) => const ResetPassword(),
            AppRoutes.bottom_bar: (context) => BottomBar(),
            AppRoutes.update_profile: (context) => const UpdateProfile(),
            AppRoutes.profile_tab: (context) => const ProfileTab(),
          },
        );
      },
    );
  }
}
