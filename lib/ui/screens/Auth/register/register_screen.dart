import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/language/language_bloc.dart';
import '../../../../bloc/language/language_event.dart';
import '../../../../models/my_user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../../utils/firebase_utils.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedIndex = 1;

  final List<String> avatars = [
    AppAssets.avatar_1,
    AppAssets.avatar_2,
    AppAssets.avatar_3,
  ];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    final localizations = AppLocalizations.of(context)!;

    // Get current language from BLoC
    final languageState = context.watch<LanguageBloc>().state;

    final selectedLanguage =
    languageState.languageCode == 'ar' ? 1 : 0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.yellow,
          ),
          backgroundColor: AppColors.black,
          title: Text(
            localizations.register,
            style: AppStyles.regular14Yellow,
          ),
        ),
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: height * 0.02,
                children: [
                  // ================= AVATARS =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      avatars.length,
                          (index) {
                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(
                              isSelected ? 4 : 0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                color: AppColors.yellow,
                                width: 4,
                              )
                                  : null,
                            ),
                            child: CircleAvatar(
                              radius: isSelected ? 60 : 45,
                              backgroundImage: AssetImage(
                                avatars[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: height * 0.01,
                  ),

                  // ================= NAME =================
                  CustomTextField(
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter a name';
                      }
                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.name,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: const Icon(
                      Icons.perm_identity_outlined,
                      color: AppColors.white,
                    ),
                  ),

                  // ================= EMAIL =================
                  CustomTextField(
                    controller: emailController,
                    KeyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter an email';
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(emailController.text)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.email,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: AppColors.white,
                    ),
                  ),

                  // ================= PASSWORD =================
                  CustomTextField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return 'Please Enter a Password';
                      }

                      if (password.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }

                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.password,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.white,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility_off_rounded,
                      color: AppColors.white,
                    ),
                  ),

                  // ================= CONFIRM PASSWORD =================
                  CustomTextField(
                    controller: rePasswordController,
                    obscureText: true,
                    validator: (rePassword) {
                      if (rePassword == null || rePassword.trim().isEmpty) {
                        return 'Please Enter a Password';
                      }

                      if (rePassword != passwordController.text) {
                        return "Re-Password doesn't match password.";
                      }

                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.confirm_password,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.white,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility_off_rounded,
                      color: AppColors.white,
                    ),
                  ),

                  // ================= PHONE =================
                  CustomTextField(
                    controller: phoneController,
                    KeyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone == null || phone.trim().isEmpty) {
                        return 'Please Enter Your Phone Number';
                      }

                      if (!RegExp(
                        r'^(01)[0-2,5]{1}[0-9]{8}$',
                      ).hasMatch(phone.trim())) {
                        return 'Please Enter a Valid Phone Number';
                      }

                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.phone_number,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.white,
                    ),
                  ),

                  // ================= REGISTER BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: register,
                      verticalPadding: height * 0.01,
                      backgroundColor: AppColors.yellow,
                      child: Text(
                        localizations.create_account,
                        style: AppStyles.regular20DarkGray,
                      ),
                    ),
                  ),

                  // ================= LOGIN =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.already_have_an_account,
                        style: AppStyles.regular14White,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login_screen,
                          );
                        },
                        child: Text(
                          localizations.login,
                          style: AppStyles.black14Yellow,
                        ),
                      ),
                    ],
                  ),

                  // ================= LANGUAGE =================
                  Container(
                    width: 130,
                    height: 62,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.yellow,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Stack(
                      children: [
                        // English flag
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<LanguageBloc>().add(
                                ChangeLanguageEvent('en'),
                              );
                            },
                            child: const SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  '🇺🇸',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Arabic flag
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              context.read<LanguageBloc>().add(
                                ChangeLanguageEvent('ar'),
                              );
                            },
                            child: const SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  '🇪🇬',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Yellow circle
                        AnimatedAlign(
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          curve: Curves.easeInOut,
                          alignment: selectedLanguage == 0
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: IgnorePointer(
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: AppColors.yellow,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                selectedLanguage == 0
                                    ? '🇺🇸'
                                    : '🇪🇬',
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= REGISTER =================

  Future<void> register() async {
    if (formKey.currentState!.validate() == true) {
      try {
        DialogUtils.showLoading(
          context: context,
          loadingText: 'Loading....',
        );

        // Firebase Auth
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Create User Model
        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
        );

        // Save User in Firestore
        await FireBaseUtils.addUserInFireStore(myUser);

        // Save User in Provider
        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );

        userProvider.updateUser(myUser);

        DialogUtils.hideLoadong(context: context);

        DialogUtils.showMessage(
          context: context,
          message: 'Register Successfully.',
          title: 'Success',
          posActionName: 'OK',
          posAction: () {
            Navigator.of(context).pushNamed(
              AppRoutes.bottom_bar,
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoadong(context: context);

        if (e.code == 'weak-password') {
          DialogUtils.showMessage(
            context: context,
            message: 'The Password provided is too weak',
            title: 'Error',
            posActionName: 'OK',
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            posActionName: 'OK',
          );
        } else {
          DialogUtils.showMessage(
            context: context,
            message: e.message ?? 'Something went wrong',
            title: 'Error',
            posActionName: 'OK',
          );
        }
      } catch (e) {
        DialogUtils.hideLoadong(context: context);

        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'OK',
        );
      }
    }
  }
}