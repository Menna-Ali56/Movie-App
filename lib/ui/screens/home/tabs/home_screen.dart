import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/ui/widgets/custom_future_builder.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? backgroundImage;
  Movies? listmovies;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 465,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: backgroundImage != null
                          ? Image.network(
                              backgroundImage!,
                              key: ValueKey<String>(backgroundImage!),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.90,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                AppAssets.homeImage,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                              ),
                            )
                          : Image.asset(
                              AppAssets.overLayer5,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.50,
                            ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.black2.withValues(alpha: 0.60),
                            AppColors.black2.withValues(alpha: 0.95),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(AppAssets.availableNow),
                      CustomFutureBuilder(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onChangeImage: (Image) {
                          setState(() {
                            backgroundImage = Image;
                          });
                        },
                      ),
                      Image.asset(
                        AppAssets.watchNow,
                        width: 245,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Action",
                        style: AppStyles.regular20White,
                      )),
                      Text(
                        "see more",
                        style: AppStyles.black14Yellow,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  CustomFutureBuilder(
                    aspectRatio: 16 / 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
