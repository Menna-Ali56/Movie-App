import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../utils/app_routes.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    var height = context.height;

    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.yellow,
          ),
          backgroundColor: AppColors.black,
          title: Text(
            localizations.forget_password,
            style: AppStyles.regular14Yellow,
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: height * 0.02,
            children: [
              Image.asset(
                AppAssets.forgetPassword,
              ),

              CustomTextField(
                controller: emailController,
                KeyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please Enter an email';
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(text.trim())) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                borderColor: AppColors.transparentColor,
                filled: true,
                fillColor: AppColors.darkGray,
                hintText: localizations.email,
                hintStyle: AppStyles.regular16White,
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.white,
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: resetPassword,
                  verticalPadding: height * 0.01,
                  backgroundColor: AppColors.yellow,
                  child: Text(
                    localizations.verify_email,
                    style: AppStyles.regular20DarkGray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      DialogUtils.showLoading(
        context: context,
        loadingText: 'Sending reset email...',
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      DialogUtils.hideLoadong(context: context);

      DialogUtils.showMessage(
        context: context,
        message:
        'Password reset email sent successfully. Please check your email.',
        posActionName: 'OK',
        posAction: () {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.login_screen,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoadong(context: context);

      String message = 'Something went wrong. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please try again later.';
      }

      DialogUtils.showMessage(
        context: context,
        message: message,
        posActionName: 'OK',
      );
    }
  }
}