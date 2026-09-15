import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/size_utils.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 1;
  int selectedLanguage = 0;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: height * 0.02,
            children: [
              Image.asset(AppAssets.movieLogo),
              SizedBox(height: height * 0.03,),
              CustomTextField(
                borderColor: AppColors.transparentColor,
                filled: true,
                fillColor: AppColors.darkGray,
                hintText: 'Email',
                hintStyle: AppStyles.regular16White,
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.white,
                ),
              ),

              CustomTextField(
                borderColor: AppColors.transparentColor,
                filled: true,
                fillColor: AppColors.darkGray,
                hintText: 'Password',
                hintStyle: AppStyles.regular16White,
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColors.white,
                ),
                suffixIcon: Icon(Icons.visibility_off_rounded
                  , color: AppColors.white,),
              ),

              TextButton(
                onPressed: () {
                  //todo:Navigation to forget Password
                },
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    'Forget Password ?',
                    style: AppStyles.regular14Yellow,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.home);
                  },
                  verticalPadding: height * 0.01,
                  backgroundColor: AppColors.yellow,
                  child: Text(
                    "Login",
                    style: AppStyles.regular20DarkGray,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have Account ?",
                    style: AppStyles.regular14White,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutes.register_screen);
                    },
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "Create One",
                        style: AppStyles.black14Yellow,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.yellow,
                      indent: width * 0.01,
                      endIndent: width * 0.04,
                    ),
                  ),
                  Text(
                    "Or",
                    style: AppStyles.regular15Yellow,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.yellow,
                      indent: width * 0.01,
                      endIndent: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {
                    //todo: Logon with google
                  },
                  verticalPadding: height * 0.02,
                  backgroundColor: AppColors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: width * 0.04,
                    children: [
                      Image.asset(AppAssets.googleLogo),
                      Text(
                        "Login With Google ",
                        style: AppStyles.regular16DarkGray,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 130,
                height: 62,

                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                ),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.yellow,
                    width: 3,
                  ),

                  borderRadius: BorderRadius.circular(35),
                ),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    // ================= ENGLISH =================

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage = 0;
                        });

                        print("English Selected");

                        // TODO: English onTap
                      },

                      child: Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: selectedLanguage == 0
                              ? AppColors.yellow
                              : AppColors.transparentColor,

                          shape: BoxShape.circle,
                        ),

                        alignment: Alignment.center,

                        child: const Text(
                          '🇺🇸',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),

                    // ================= ARABIC =================

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage = 1;
                        });

                        print("Arabic Selected");

                        // TODO: Arabic onTap
                      },

                      child: Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: selectedLanguage == 1
                              ? AppColors.yellow
                              : AppColors.transparentColor,

                          shape: BoxShape.circle,
                        ),

                        alignment: Alignment.center,

                        child: const Text(
                          '🇪🇬',
                          style: TextStyle(
                            fontSize: 30,
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
    );
  }

}
