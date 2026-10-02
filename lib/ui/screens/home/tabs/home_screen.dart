import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_genre.dart';
import 'package:movie_app/ui/widgets/custom_future_builder.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/ui/screens/home/size_config.dart';

import '../../../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

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
            width: double.infinity,
            height: SizeConfig.h(context, 465),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: backgroundImage != null
                        ? SizedBox.expand(
                            child: Image.network(
                              backgroundImage!,
                              key: ValueKey<String>(backgroundImage!),
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                AppAssets.mainLay,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Image.asset(
                            AppAssets.overLayer5,
                            fit: BoxFit.fill,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.h(context, 120),
                      child: Center(
                        child: Image.asset(
                          AppAssets.availableNow,
                          fit: BoxFit.contain,
                          width: SizeConfig.w(context, 180),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.h(context, 260),
                      child: CustomFutureBuilder(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onChangeImage: (Image) {
                          setState(() {
                            backgroundImage = Image;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.h(context, 80),
                      child: Center(
                        child: Image.asset(
                          AppAssets.watchNow,
                          fit: BoxFit.contain,
                          width: SizeConfig.w(context, 245),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MovieGenre(),
        ],
      ),
    ));
  }
}
