import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(40, 42, 40, 1),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 24, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  AppAssets.avatar_1,
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  userProvider.currentUser!.name,
                                  style: AppStyles.roboto20White500,
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 25),
                              child: Column(
                                children: [
                                  Text(
                                    "12",
                                    style: AppStyles.bold24White,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Wish List",
                                    style: AppStyles.regular20White,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "10",
                                  style: AppStyles.bold24White,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "History",
                                  style: AppStyles.regular20White,
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24, right: 10, bottom: 24),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomElevatedButton(
                                  backgroundColor: AppColors.yellow,
                                  radius: 15,
                                  verticalPadding: 15,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.update_profile,
                                    );
                                  },
                                  child: Text(
                                    "Edit Profile",
                                    style: AppStyles.regular20DarkGray,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomElevatedButton(
                                  backgroundColor: AppColors.red,
                                  radius: 15,
                                  verticalPadding: 15,
                                  onPressed: () {},
                                  child: Image.asset(AppAssets.iconExit),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(TabBar(
                        indicatorColor: AppColors.yellow,
                        dividerColor: AppColors.transparentColor,
                        unselectedLabelColor: AppColors.transparentColor,
                        tabs: [
                          Tab(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.list,
                                  color: AppColors.yellow,
                                ),
                                Text(
                                  "Watch List",
                                  style: AppStyles.regular14White,
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.folder,
                                  color: AppColors.yellow,
                                ),
                                Text(
                                  "History",
                                  style: AppStyles.regular14White,
                                ),
                              ],
                            ),
                          )
                        ]))),
              ];
            },
            body: TabBarView(children: [
              Container(
                color: AppColors.black2,
                child: Center(
                  child: Image.asset(AppAssets.emtySearch),
                ),
              ),
              Container(
                color: AppColors.black2,
                child: Center(
                  child: Image.asset(AppAssets.emtySearch),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
