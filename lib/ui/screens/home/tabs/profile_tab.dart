import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/firebase_utils.dart';

import '../widgets/movie_card.dart';
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<List<Movies>>? historyFuture;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    var userProvider=Provider.of<UserProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    historyFuture ??= user == null
        ? null
        : FireBaseUtils.getHistory(user.uid);
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
                                    localizations.wish_list,
                                    style: AppStyles.regular20White,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                FutureBuilder<List<Movies>>(
                                  future: historyFuture,
                                  builder: (context, snapshot) {
                                    final historyCount = snapshot.data?.length ?? 0;

                                    return Text(
                                      historyCount.toString(),
                                      style: AppStyles.bold24White,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  localizations.history,
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
                                    localizations.edit_profile,
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
                                  onPressed: () {

                                  },
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
                                  localizations.watch_list,
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
                                  localizations.history,
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
                child: user == null
                    ? Center(
                  child: Text(
                    "Please login first",
                    style: AppStyles.regular16White,
                  ),
                )
                    : FutureBuilder<List<Movies>>(
                  future: FireBaseUtils.getHistory(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellow,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Something went wrong",
                          style: AppStyles.regular16White,
                        ),
                      );
                    }

                    final history = snapshot.data ?? [];

                    if (history.isEmpty) {
                      return Center(
                        child: Image.asset(AppAssets.emtySearch),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: history[index],
                        );
                      },
                    );
                  },
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
