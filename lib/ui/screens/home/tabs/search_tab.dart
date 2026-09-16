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
        backgroundColor: AppColors.black2,
        body: SizedBox(
          child: Container(
            height: SizeConfig.height(context),
            width: SizeConfig.width(context),
            child: Column(
              children: [
                Container(
                  height: 55,
                  width: 398,
                  margin: EdgeInsets.only(top: 21, right: 16, left: 16),
                  decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    style: TextStyle(color: AppColors.yellow),
                    decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 17, left: 10, bottom: 17),
                        child: Image.asset(AppAssets.searchTab),
                      ),
                      hintText: "Search ",
                      hintStyle: TextStyle(color: AppColors.white),
                      contentPadding: EdgeInsets.only(top: 19, bottom: 19),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 1,
                        ),
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
