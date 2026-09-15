import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/size_utils.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedIndex = 1;

  // Language
  int selectedLanguage = 0;

  final List<String> avatars = [
    AppAssets.avatar_1,
    AppAssets.avatar_2,
    AppAssets.avatar_3,
  ];

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.yellow,
          ),
          backgroundColor: AppColors.black,
          title: Text(
            "Register",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: height * 0.02,
              children: [
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

                          print('Selected Avatar: $index');
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
                CustomTextField(
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGray,
                  hintText: 'Name',
                  hintStyle: AppStyles.regular16White,
                  prefixIcon: Icon(
                    Icons.perm_identity_outlined,
                    color: AppColors.white,
                  ),
                ),
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
                  suffixIcon: Icon(
                    Icons.visibility_off_rounded,
                    color: AppColors.white,
                  ),
                ),
                CustomTextField(
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGray,
                  hintText: 'Confirm Password',
                  hintStyle: AppStyles.regular16White,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.white,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_rounded,
                    color: AppColors.white,
                  ),
                ),
                CustomTextField(
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGray,
                  hintText: 'Phone Number',
                  hintStyle: AppStyles.regular16White,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.login_screen);
                    },
                    verticalPadding: height * 0.01,
                    backgroundColor: AppColors.yellow,
                    child: Text(
                      "Create Account",
                      style: AppStyles.regular20DarkGray,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account ?",
                      style: AppStyles.regular14White,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login_screen);
                      },
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "Login",
                          style: AppStyles.black14Yellow,
                        ),
                      ),
                    ),
                  ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
      ),
    );
  }
}
