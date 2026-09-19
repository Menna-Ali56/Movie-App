import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/screens/home/tabs/browse_tab.dart';
import 'package:movie_app/ui/screens/home/tabs/home_screen.dart';
import 'package:movie_app/ui/screens/home/tabs/profile_tab.dart';
import 'package:movie_app/ui/screens/home/tabs/search_tab.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> tabs = [HomeScreen(), SearchTab(), BrowseTab(), ProfileTab()];
  int currentIndex = 0;
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparentColor,
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(right: 9, left: 9, bottom: 9),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColors.transparentColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
              splashColor: AppColors.transparentColor,
              highlightColor: AppColors.transparentColor),
          child: BottomNavigationBar(
            backgroundColor: AppColors.darkGray,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            useLegacyColorScheme: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.homeTab,
                  color: currentIndex == 0 ? AppColors.yellow : AppColors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.searchTab,
                  color: currentIndex == 1 ? AppColors.yellow : AppColors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.browseTab,
                  color: currentIndex == 2 ? AppColors.yellow : AppColors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.profileTab,
                  color: currentIndex == 3 ? AppColors.yellow : AppColors.white,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
