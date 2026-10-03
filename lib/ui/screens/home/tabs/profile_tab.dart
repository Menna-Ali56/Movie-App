//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:movie_app/bloc/user/user_bloc.dart';
// import 'package:movie_app/bloc/user/user_state.dart';
// import 'package:movie_app/bloc/user/user_event.dart';
//
// import 'package:movie_app/l10n/app_localizations.dart';
// import 'package:movie_app/models/movie_model.dart';
// import 'package:movie_app/ui/screens/home/size_config.dart';
// import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
// import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
//
// import 'package:movie_app/utils/app_assets.dart';
// import 'package:movie_app/utils/app_colors.dart';
// import 'package:movie_app/utils/app_routes.dart';
// import 'package:movie_app/utils/app_styles.dart';
// import 'package:movie_app/utils/firebase_utils.dart';
//
// class ProfileTab extends StatefulWidget {
//   const ProfileTab({super.key});
//
//   @override
//   State<ProfileTab> createState() => _ProfileTabState();
// }
//
// class _ProfileTabState extends State<ProfileTab> {
//   Future<List<Movies>>? historyFuture;
//   Future<List<Movies>>? watchListFuture;
//   Future<int>? watchListCountFuture;
//
//   @override
//   void initState() {
//     super.initState();
//
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       historyFuture = FireBaseUtils.getHistory(user.uid);
//
//       watchListFuture = FireBaseUtils.getWatchList(user.uid);
//
//       watchListCountFuture =
//           FireBaseUtils.getWatchListCount(user.uid);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;
//
//     final userState = context.watch<UserBloc>().state;
//
//     final user = FirebaseAuth.instance.currentUser;
//
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: const Color.fromRGBO(40, 42, 40, 1),
//
//           body: NestedScrollView(
//             headerSliverBuilder: (context, innerBoxIsScrolled) {
//               return [
//                 // =====================================================
//                 // PROFILE HEADER
//                 // =====================================================
//
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: SizeConfig.only(
//                       context,
//                       top: 24,
//                       left: 24,
//                       right: 10,
//                     ),
//
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             // =================================================
//                             // AVATAR + NAME
//                             // =================================================
//
//                             Column(
//                               children: [
//                                 Image.asset(
//                                   AppAssets.avatar_1,
//                                   height: SizeConfig.h(
//                                     context,
//                                     100,
//                                   ),
//                                   width: SizeConfig.w(
//                                     context,
//                                     100,
//                                   ),
//                                 ),
//
//                                 SizedBox(
//                                   height: SizeConfig.h(
//                                     context,
//                                     15,
//                                   ),
//                                 ),
//
//                                 Text(
//                                   userState is UserSuccess
//                                       ? userState.user.name
//                                       : '',
//                                   style:
//                                   AppStyles.roboto20White500,
//                                 ),
//                               ],
//                             ),
//
//                             // =================================================
//                             // WATCH LIST COUNT
//                             // =================================================
//
//                             Padding(
//                               padding: SizeConfig.only(
//                                 context,
//                                 left: 20,
//                                 right: 25,
//                               ),
//
//                               child: Column(
//                                 children: [
//                                   FutureBuilder<int>(
//                                     future: watchListCountFuture,
//
//                                     builder:
//                                         (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return const SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child:
//                                           CircularProgressIndicator(
//                                             color:
//                                             AppColors.yellow,
//                                             strokeWidth: 2,
//                                           ),
//                                         );
//                                       }
//
//                                       return Text(
//                                         (snapshot.data ?? 0)
//                                             .toString(),
//                                         style:
//                                         AppStyles.bold24White,
//                                       );
//                                     },
//                                   ),
//
//                                   SizedBox(
//                                     height: SizeConfig.h(
//                                       context,
//                                       10,
//                                     ),
//                                   ),
//
//                                   Text(
//                                     localizations.watch_list,
//                                     style:
//                                     AppStyles.regular20White,
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             // =================================================
//                             // HISTORY COUNT
//                             // =================================================
//
//                             Column(
//                               children: [
//                                 FutureBuilder<List<Movies>>(
//                                   future: historyFuture,
//
//                                   builder:
//                                       (context, snapshot) {
//                                     final historyCount =
//                                         snapshot.data?.length ??
//                                             0;
//
//                                     return Text(
//                                       historyCount.toString(),
//                                       style:
//                                       AppStyles.bold24White,
//                                     );
//                                   },
//                                 ),
//
//                                 SizedBox(
//                                   height: SizeConfig.h(
//                                     context,
//                                     10,
//                                   ),
//                                 ),
//
//                                 Text(
//                                   localizations.history,
//                                   style:
//                                   AppStyles.regular20White,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//
//                         // =====================================================
//                         // EDIT PROFILE + EXIT
//                         // =====================================================
//
//                         Padding(
//                           padding: SizeConfig.only(
//                             context,
//                             top: 24,
//                             right: 10,
//                             bottom: 24,
//                           ),
//
//                           child: Row(
//                             children: [
//                               // ===============================
//                               // EDIT PROFILE
//                               // ===============================
//
//                               Expanded(
//                                 flex: 2,
//
//                                 child:
//                                 CustomElevatedButton(
//                                   backgroundColor:
//                                   AppColors.yellow,
//
//                                   radius:
//                                   SizeConfig.w(
//                                     context,
//                                     15,
//                                   ),
//
//                                   verticalPadding:
//                                   SizeConfig.h(
//                                     context,
//                                     15,
//                                   ),
//
//                                   onPressed: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       AppRoutes.update_profile,
//                                     );
//                                   },
//
//                                   child: Text(
//                                     localizations.edit_profile,
//                                     style: AppStyles
//                                         .regular20DarkGray,
//                                   ),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.w(
//                                   context,
//                                   10,
//                                 ),
//                               ),
//
//                               // ===============================
//                               // EXIT
//                               // ===============================
//
//                               Expanded(
//                                 flex: 1,
//
//                                 child:
//                                 CustomElevatedButton(
//                                   backgroundColor:
//                                   AppColors.red,
//
//                                   radius:
//                                   SizeConfig.w(
//                                     context,
//                                     15,
//                                   ),
//
//                                   verticalPadding:
//                                   SizeConfig.h(
//                                     context,
//                                     15,
//                                   ),
//
//                                   onPressed: () async {
//                                     await FirebaseAuth
//                                         .instance
//                                         .signOut();
//
//                                     if (!context.mounted) {
//                                       return;
//                                     }
//
//                                     context
//                                         .read<UserBloc>()
//                                         .add(
//                                       ClearUserEvent(),
//                                     );
//
//                                     Navigator
//                                         .pushNamedAndRemoveUntil(
//                                       context,
//                                       AppRoutes.login_screen,
//                                           (route) => false,
//                                     );
//                                   },
//
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//
//                                     children: [
//                                       Text(
//                                         localizations.exit,
//                                         style: AppStyles
//                                             .regular20White,
//                                       ),
//
//                                       SizedBox(
//                                         width: SizeConfig.w(
//                                           context,
//                                           8,
//                                         ),
//                                       ),
//
//                                       const Icon(
//                                         Icons
//                                             .exit_to_app_outlined,
//                                         color:
//                                         AppColors.white,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // =====================================================
//                 // TAB BAR
//                 // =====================================================
//
//                 SliverPersistentHeader(
//                   pinned: true,
//
//                   delegate:
//                   _SliverTabBarDelegate(
//                     TabBar(
//                       indicatorColor:
//                       AppColors.yellow,
//
//                       dividerColor:
//                       AppColors.transparentColor,
//
//                       unselectedLabelColor:
//                       AppColors.transparentColor,
//
//                       tabs: [
//                         // ===============================
//                         // WATCH LIST
//                         // ===============================
//
//                         Tab(
//                           child: Column(
//                             children: [
//                               const Icon(
//                                 Icons.list,
//                                 color:
//                                 AppColors.yellow,
//                               ),
//
//                               Text(
//                                 localizations.watch_list,
//                                 style: AppStyles
//                                     .regular14White,
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // ===============================
//                         // HISTORY
//                         // ===============================
//
//                         Tab(
//                           child: Column(
//                             children: [
//                               const Icon(
//                                 Icons.folder,
//                                 color:
//                                 AppColors.yellow,
//                               ),
//
//                               Text(
//                                 localizations.history,
//                                 style: AppStyles
//                                     .regular14White,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ];
//             },
//
//             // =========================================================
//             // TAB BAR VIEW
//             // =========================================================
//
//             body: TabBarView(
//               children: [
//                 // =====================================================
//                 // WATCH LIST
//                 // =====================================================
//
//                 Container(
//                   color: AppColors.black2,
//
//                   child: user == null
//                       ? Center(
//                     child: Text(
//                       "Please login first",
//                       style:
//                       AppStyles.regular16White,
//                     ),
//                   )
//                       : FutureBuilder<List<Movies>>(
//                     future: watchListFuture,
//
//                     builder:
//                         (context, snapshot) {
//                       // ============================
//                       // LOADING
//                       // ============================
//
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(
//                           child:
//                           CircularProgressIndicator(
//                             color:
//                             AppColors.yellow,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // ERROR
//                       // ============================
//
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             "Something went wrong",
//                             style: AppStyles
//                                 .regular16White,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // DATA
//                       // ============================
//
//                       final watchList =
//                           snapshot.data ?? [];
//
//                       // ============================
//                       // EMPTY
//                       // ============================
//
//                       if (watchList.isEmpty) {
//                         return Center(
//                           child: Image.asset(
//                             AppAssets.emtySearch,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // MOVIES
//                       // ============================
//
//                       return GridView.builder(
//                         padding:
//                         SizeConfig.all(
//                           context,
//                           10,
//                         ),
//
//                         gridDelegate:
//                         SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//
//                           childAspectRatio: 0.7,
//
//                           crossAxisSpacing:
//                           SizeConfig.w(
//                             context,
//                             12,
//                           ),
//
//                           mainAxisSpacing:
//                           SizeConfig.h(
//                             context,
//                             12,
//                           ),
//                         ),
//
//                         itemCount:
//                         watchList.length,
//
//                         itemBuilder:
//                             (context, index) {
//                           return MovieCard(
//                             movie:
//                             watchList[index],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//
//                 // =====================================================
//                 // HISTORY
//                 // =====================================================
//
//                 Container(
//                   color: AppColors.black2,
//
//                   child: user == null
//                       ? Center(
//                     child: Text(
//                       "Please login first",
//                       style:
//                       AppStyles.regular16White,
//                     ),
//                   )
//                       : FutureBuilder<List<Movies>>(
//                     future: historyFuture,
//
//                     builder:
//                         (context, snapshot) {
//                       // ============================
//                       // LOADING
//                       // ============================
//
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(
//                           child:
//                           CircularProgressIndicator(
//                             color:
//                             AppColors.yellow,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // ERROR
//                       // ============================
//
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             "Something went wrong",
//                             style: AppStyles
//                                 .regular16White,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // DATA
//                       // ============================
//
//                       final history =
//                           snapshot.data ?? [];
//
//                       // ============================
//                       // EMPTY
//                       // ============================
//
//                       if (history.isEmpty) {
//                         return Center(
//                           child: Image.asset(
//                             AppAssets.emtySearch,
//                           ),
//                         );
//                       }
//
//                       // ============================
//                       // MOVIES
//                       // ============================
//
//                       return GridView.builder(
//                         padding:
//                         SizeConfig.all(
//                           context,
//                           10,
//                         ),
//
//                         gridDelegate:
//                         SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//
//                           childAspectRatio: 0.7,
//
//                           crossAxisSpacing:
//                           SizeConfig.w(
//                             context,
//                             12,
//                           ),
//
//                           mainAxisSpacing:
//                           SizeConfig.h(
//                             context,
//                             12,
//                           ),
//                         ),
//
//                         itemCount:
//                         history.length,
//
//                         itemBuilder:
//                             (context, index) {
//                           return MovieCard(
//                             movie:
//                             history[index],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // =============================================================
// // TAB BAR DELEGATE
// // =============================================================
//
// class _SliverTabBarDelegate
//     extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;
//
//   _SliverTabBarDelegate(this.tabBar);
//
//   @override
//   Widget build(
//       BuildContext context,
//       double shrinkOffset,
//       bool overlapsContent,
//       ) {
//     return Container(
//       child: tabBar,
//     );
//   }
//
//   @override
//   double get maxExtent =>
//       tabBar.preferredSize.height;
//
//   @override
//   double get minExtent =>
//       tabBar.preferredSize.height;
//
//   @override
//   bool shouldRebuild(
//       covariant _SliverTabBarDelegate oldDelegate,
//       ) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:movie_app/bloc/user/user_bloc.dart';
import 'package:movie_app/bloc/user/user_state.dart';
import 'package:movie_app/bloc/user/user_event.dart';

import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/size_config.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';

import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/firebase_utils.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<List<Movies>>? historyFuture;
  Future<List<Movies>>? watchListFuture;
  Future<int>? wishListCountFuture;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    historyFuture = FireBaseUtils.getHistory(user.uid);

    watchListFuture =
        FireBaseUtils.getWatchList(user.uid);

    wishListCountFuture =
        FireBaseUtils.getSaveCount(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    final userState =
        context.watch<UserBloc>().state;

    final user =
        FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor:
          const Color.fromRGBO(40, 42, 40, 1),
          body: NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.only(
                      context,
                      top: 24,
                      left: 24,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // =========================
                            // PROFILE IMAGE + NAME
                            // =========================
                            Column(
                              children: [
                                Image.asset(
                                  AppAssets.avatar_1,
                                  height: SizeConfig.h(
                                    context,
                                    100,
                                  ),
                                  width: SizeConfig.w(
                                    context,
                                    100,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.h(
                                    context,
                                    15,
                                  ),
                                ),
                                Text(
                                  userState is UserSuccess
                                      ? userState.user.name
                                      : '',
                                  style: AppStyles
                                      .roboto20White500,
                                ),
                              ],
                            ),

                            // =========================
                            // WISH LIST COUNT
                            // =========================
                            Padding(
                              padding: SizeConfig.only(
                                context,
                                left: 20,
                                right: 15,
                              ),
                              child: Column(
                                children: [
                                  FutureBuilder<int>(
                                    future:
                                    wishListCountFuture,
                                    builder:
                                        (context, snapshot) {
                                      if (snapshot
                                          .connectionState ==
                                          ConnectionState
                                              .waiting) {
                                        return const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child:
                                          CircularProgressIndicator(
                                            color:
                                            AppColors
                                                .yellow,
                                            strokeWidth: 2,
                                          ),
                                        );
                                      }

                                      return Text(
                                        (snapshot.data ?? 0)
                                            .toString(),
                                        style: AppStyles
                                            .bold24White,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: SizeConfig.h(
                                      context,
                                      10,
                                    ),
                                  ),
                                   Text(
                                    'Wish List',
                                    style: AppStyles
                                        .regular20White,
                                  ),
                                ],
                              ),
                            ),

                            // =========================
                            // HISTORY COUNT
                            // =========================
                            Column(
                              children: [
                                FutureBuilder<List<Movies>>(
                                  future: historyFuture,
                                  builder:
                                      (context, snapshot) {
                                    final historyCount =
                                        snapshot.data
                                            ?.length ??
                                            0;

                                    return Text(
                                      historyCount
                                          .toString(),
                                      style: AppStyles
                                          .bold24White,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: SizeConfig.h(
                                    context,
                                    10,
                                  ),
                                ),
                                Text(
                                  localizations.history,
                                  style: AppStyles
                                      .regular20White,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // =========================
                        // EDIT PROFILE + LOGOUT
                        // =========================
                        Padding(
                          padding: SizeConfig.only(
                            context,
                            top: 24,
                            right: 10,
                            bottom: 24,
                          ),
                          child: Row(
                            children: [
                              // EDIT PROFILE
                              Expanded(
                                flex: 2,
                                child:
                                CustomElevatedButton(
                                  backgroundColor:
                                  AppColors.yellow,
                                  radius:
                                  SizeConfig.w(
                                    context,
                                    15,
                                  ),
                                  verticalPadding:
                                  SizeConfig.h(
                                    context,
                                    15,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes
                                          .update_profile,
                                    );
                                  },
                                  child: Text(
                                    localizations
                                        .edit_profile,
                                    style: AppStyles
                                        .regular20DarkGray,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: SizeConfig.w(
                                  context,
                                  10,
                                ),
                              ),

                              // LOGOUT
                              Expanded(
                                flex: 1,
                                child:
                                CustomElevatedButton(
                                  backgroundColor:
                                  AppColors.red,
                                  radius:
                                  SizeConfig.w(
                                    context,
                                    15,
                                  ),
                                  verticalPadding:
                                  SizeConfig.h(
                                    context,
                                    15,
                                  ),
                                  onPressed: () async {
                                    await FirebaseAuth
                                        .instance
                                        .signOut();

                                    if (!context.mounted) {
                                      return;
                                    }

                                    context
                                        .read<UserBloc>()
                                        .add(
                                      ClearUserEvent(),
                                    );

                                    Navigator
                                        .pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes
                                          .login_screen,
                                          (route) => false,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        localizations.exit,
                                        style: AppStyles
                                            .regular20White,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.w(
                                          context,
                                          8,
                                        ),
                                      ),
                                      const Icon(
                                        Icons
                                            .exit_to_app_outlined,
                                        color:
                                        AppColors.white,
                                      ),
                                    ],
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

                // =========================
                // TABS
                // =========================
                SliverPersistentHeader(
                  pinned: true,
                  delegate:
                  _SliverTabBarDelegate(
                    TabBar(
                      indicatorColor:
                      AppColors.yellow,
                      dividerColor:
                      AppColors.transparentColor,
                      unselectedLabelColor:
                      AppColors.transparentColor,
                      tabs: [
                        // WATCH LIST
                        Tab(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.list,
                                color:
                                AppColors.yellow,
                              ),
                              Text(
                                localizations.watch_list,
                                style: AppStyles
                                    .regular14White,
                              ),
                            ],
                          ),
                        ),

                        // HISTORY
                        Tab(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.folder,
                                color:
                                AppColors.yellow,
                              ),
                              Text(
                                localizations.history,
                                style: AppStyles
                                    .regular14White,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },

            // =========================
            // TAB CONTENT
            // =========================
            body: TabBarView(
              children: [
                // =========================
                // WATCH LIST
                // =========================
                Container(
                  color: AppColors.black2,
                  child: user == null
                      ? _loginMessage()
                      : FutureBuilder<List<Movies>>(
                    future: watchListFuture,
                    builder:
                        (context, snapshot) {
                      if (snapshot
                          .connectionState ==
                          ConnectionState
                              .waiting) {
                        return const Center(
                          child:
                          CircularProgressIndicator(
                            color:
                            AppColors.yellow,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return _errorMessage();
                      }

                      final watchList =
                          snapshot.data ?? [];

                      if (watchList.isEmpty) {
                        return _emptyImage();
                      }

                      return _movieGrid(
                        watchList,
                      );
                    },
                  ),
                ),

                // =========================
                // HISTORY
                // =========================
                Container(
                  color: AppColors.black2,
                  child: user == null
                      ? _loginMessage()
                      : FutureBuilder<List<Movies>>(
                    future: historyFuture,
                    builder:
                        (context, snapshot) {
                      if (snapshot
                          .connectionState ==
                          ConnectionState
                              .waiting) {
                        return const Center(
                          child:
                          CircularProgressIndicator(
                            color:
                            AppColors.yellow,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return _errorMessage();
                      }

                      final history =
                          snapshot.data ?? [];

                      if (history.isEmpty) {
                        return _emptyImage();
                      }

                      return _movieGrid(
                        history,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // MOVIE GRID
  // =========================
  Widget _movieGrid(List<Movies> movies) {
    return GridView.builder(
      padding: SizeConfig.all(
        context,
        10,
      ),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing:
        SizeConfig.w(
          context,
          12,
        ),
        mainAxisSpacing:
        SizeConfig.h(
          context,
          12,
        ),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
        );
      },
    );
  }

  // =========================
  // EMPTY
  // =========================
  Widget _emptyImage() {
    return Center(
      child: Image.asset(
        AppAssets.emtySearch,
      ),
    );
  }

  // =========================
  // LOGIN MESSAGE
  // =========================
  Widget _loginMessage() {
    return Center(
      child: Text(
        "Please login first",
        style: AppStyles.regular16White,
      ),
    );
  }

  // =========================
  // ERROR MESSAGE
  // =========================
  Widget _errorMessage() {
    return Center(
      child: Text(
        "Something went wrong",
        style: AppStyles.regular16White,
      ),
    );
  }
}

// =========================
// SLIVER TAB BAR DELEGATE
// =========================
class _SliverTabBarDelegate
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: AppColors.black2,
      child: tabBar,
    );
  }

  @override
  double get maxExtent =>
      tabBar.preferredSize.height;

  @override
  double get minExtent =>
      tabBar.preferredSize.height;

  @override
  bool shouldRebuild(
      covariant _SliverTabBarDelegate oldDelegate,
      ) {
    return false;
  }
}