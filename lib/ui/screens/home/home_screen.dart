import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: backgroundImage != null
                  ? Image.network(
                      backgroundImage!,
                      key: ValueKey<String>(backgroundImage!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AppAssets.homeImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : Image.asset(
                      AppAssets.homeImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
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
                    AppColors.black.withValues(alpha: 0.60),
                    AppColors.black.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: AppColors.transparentColor,
            body: SizedBox(
              width: SizeConfig.width(context),
              height: SizeConfig.height(context),
              child: Column(
                children: [
                  Image.asset(AppAssets.availableNow),
                  Expanded(
                    child: FutureBuilder(
                      future: ApiMovie.getMovie(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        }
                        if (snap.hasError) {
                          return const Center(
                            child: Text(
                              "Something went wrong",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        if (snap.data?.status != 'ok') {
                          return Center(
                            child: Text(
                              snap.data?.statusMessage ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        List<Movies> movieList = snap.data?.data?.movies ?? [];

                        if (movieList.isEmpty) {
                          return const Center(
                            child: Text(
                              "No movies found",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        if (backgroundImage == null && movieList.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                backgroundImage =
                                    movieList[0].backgroundImageOriginal ??
                                        movieList[1].largeCoverImage;
                              });
                            }
                          });
                        }

                        return CarouselSlider.builder(
                          itemCount: movieList.length,
                          itemBuilder: (context, index, realIndex) {
                            Movies movie = movieList[index];
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                "${movie.mediumCoverImage}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                            aspectRatio: 8 / 6,
                            initialPage: 0,
                            clipBehavior: Clip.antiAlias,
                            // onPageChanged: (index, reason) {
                            //   setState(() {
                            //     backgroundImage =
                            //         movieList[index].backgroundImageOriginal ??
                            //             movieList[index].largeCoverImage;
                            //   });
                            // },
                          ),
                        );
                      },
                    ),
                  ),
                  Image.asset(AppAssets.watchNow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
