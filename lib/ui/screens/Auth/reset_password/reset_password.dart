import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../utils/app_routes.dart';
import '../../../../utils/app_styles.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: height * 0.02,
          children: [
            Image.asset(
              AppAssets.forgetPassword,
            ),
            CustomTextField(
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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.login_screen,
                  );
                },
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
    );
  }
}