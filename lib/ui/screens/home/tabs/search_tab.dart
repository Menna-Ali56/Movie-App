import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.black2,
        body: SizedBox(
          child: Container(
            height: SizeConfig.height(context),
            width: SizeConfig.width(context),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: AppColors.yellow),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 17, left: 10, bottom: 17),
                        child: Image.asset(AppAssets.searchTab),
                      ),
                      fillColor: AppColors.darkGray,
                      filled: true,
                      hintText: "Search ",
                      hintStyle: TextStyle(color: AppColors.white),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(AppAssets.emtySearch),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
