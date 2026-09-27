import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.transparentColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        leading: InkWell(
          splashColor: AppColors.transparentColor,
          highlightColor: AppColors.transparentColor,
          autofocus: true,
          onTap: () {
            Navigator.pop(
              context,
              AppRoutes.bottom_bar,
            );
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.yellow,
          ),
        ),
        title: Center(
          child: Text(
            "Pick Avatar",
            style: AppStyles.regular14Yellow,
          ),
        ),
        actions: [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                splashColor: AppColors.transparentColor,
                highlightColor: AppColors.transparentColor,
                child: Center(child: Image.asset(AppAssets.avatar_1)),
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.transparentColor,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 14),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.darkGray,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: AppAssets.listUpdatProfile.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: AppColors.transparentColor,
                                    highlightColor: AppColors.transparentColor,
                                    onTap: () {
                                      Navigator.pop(context,
                                          AppAssets.listUpdatProfile[index]);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: AppColors.yellow,
                                              width: 1)),
                                      child: Image.asset(
                                          AppAssets.listUpdatProfile[index]),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                cursorColor: AppColors.yellow,
                style: TextStyle(color: AppColors.yellow),
                decoration: InputDecoration(
                  fillColor: AppColors.darkGray,
                  filled: true,
                  prefixIcon: Image.asset(AppAssets.user),
                  hintText: 'John Safwat',
                  hintStyle: AppStyles.roboto20White500,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.darkGray, width: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
              child: TextField(
                style: TextStyle(color: AppColors.yellow),
                decoration: InputDecoration(
                  fillColor: AppColors.darkGray,
                  filled: true,
                  prefixIcon: Image.asset(AppAssets.phone),
                  hintText: '01200000000',
                  hintStyle: TextStyle(color: AppColors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.darkGray, width: 1),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 30, right: 10, left: 10, bottom: 15),
                    child: Text(
                      "Reset Password",
                      style: AppStyles.regular20White,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.red,
                        radius: 15,
                        verticalPadding: 15,
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, AppRoutes.update_profile);
                        },
                        child: Text(
                          "Delete Account",
                          style: AppStyles.regular20DarkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.yellow,
                        radius: 15,
                        verticalPadding: 15,
                        horizontalPadding: 5,
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, AppRoutes.update_profile);
                        },
                        child: Text(
                          "Edit Profile",
                          style: AppStyles.regular20DarkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
