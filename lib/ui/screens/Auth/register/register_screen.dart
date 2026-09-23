import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/size_utils.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/dialog_utils.dart';
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
  var rePasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
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
                    prefixIcon: Icon(
                      Icons.perm_identity_outlined,
                      color: AppColors.white,
                    ),
                  ),

                  CustomTextField(
                    controller: emailController,
                    KeyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter an email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
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
                    controller: rePasswordController,
                    obscureText: true,
                    validator: (rePassword) {
                      if (rePassword == null || rePassword.trim().isEmpty) {
                        return 'Please Enter a Password';
                      }
                      if (rePassword != passwordController.text ) {
                        return "Re-Password doesn't match password.";
                      }
                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.confirm_password,
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
                    controller: phoneController,
                    KeyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone == null || phone.trim().isEmpty) {
                        return 'Please Enter Your Phone Number';
                      }

                      if (!RegExp(r'^(01)[0-2,5]{1}[0-9]{8}$').hasMatch(phone.trim())) {
                        return 'Please Enter a Valid Phone Number';
                      }

                      return null;
                    },
                    borderColor: AppColors.transparentColor,
                    filled: true,
                    fillColor: AppColors.darkGray,
                    hintText: localizations.phone_number,
                    hintStyle: AppStyles.regular16White,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed:register,
                      verticalPadding: height * 0.01,
                      backgroundColor: AppColors.yellow,
                      child: Text(
                        localizations.create_account,
                        style: AppStyles.regular20DarkGray,
                      ),
                    ),
                  ),

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
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            localizations.login,
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
      ),
    );
  }
  void register()async{
    if (formKey.currentState!.validate()==true) {
      try {
        //todo: show loadding
        DialogUtils.showLoading(context: context, loadingText: 'Loading....');
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading
        DialogUtils.hideLoadong(context: context);


        // todo: show message
        DialogUtils.showMessage(context: context,
            message: 'Register Successfully.',
            title: 'Success',posActionName: 'OK',posAction: (){
              Navigator.of(context).pushNamed(AppRoutes.bottom_bar);
            });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoadong(context: context);
          // todo: show message>> error
          DialogUtils.showMessage(context: context,
              message: 'The Password provoded is too weak',
              title: 'Error',posActionName: 'OK');


        } else if (e.code == 'email-already-in-use') {

          //todo: hide loading
          DialogUtils.hideLoadong(context: context);
          // todo: show message>> error
          DialogUtils.showMessage(context: context,
              message:'The account already exists for that email.' ,
              title: 'Error',posActionName: 'OK');


        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoadong(context: context);
        // todo: show message>> error
        DialogUtils.showMessage(context: context,
            message: e.toString(),
            title: 'Error',posActionName: 'OK');

      }

    }
  }
}