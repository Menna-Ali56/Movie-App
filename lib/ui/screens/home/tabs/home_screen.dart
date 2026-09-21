import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/utils/app_assets.dart';

import '../../../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeScreen()];
  String? backgroundImage;
  late Future<dynamic> ImageMovie;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    ImageMovie = ApiMovie.getMovie();
  }

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
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.90,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AppAssets.homeImage,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.92,
                      ),
                    )
                  : Image.asset(
                      AppAssets.overLayer5,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.90,
                    ),
            ),
          ),
          Positioned.fill(
            bottom: 200,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black2.withValues(alpha: 0.60),
                    AppColors.black2.withValues(alpha: 2.5),
                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: AppColors.transparentColor,
            body: SizedBox(
              child: Column(
                children: [
                  Image.asset(AppAssets.availableNow),
                  Expanded(
                    child: FutureBuilder(
                      future: ImageMovie,
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
                                backgroundImage = movieList[0].largeCoverImage;
                              });
                            }
                          });
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: movieList.length,
                                itemBuilder: (context, index, realIndex) {
                                  final movie = movieList[index];
                                  return MovieCard(movie: movie);
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.5,
                                  aspectRatio: 8 / 6,
                                  initialPage: 0,
                                  clipBehavior: Clip.antiAlias,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 500),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                      backgroundImage =
                                          movieList[index].largeCoverImage;
                                    });
                                  },
                                ),
                              ),
                              Image.asset(
                                AppAssets.watchNow,
                                width: 245,
                              ),
                              CarouselSlider.builder(
                                itemCount: movieList.length,
                                itemBuilder: (context, index, realIndex) {
                                  final movie = movieList[index];
                                  return MovieCard(movie: movie);
                                },
                                options: CarouselOptions(
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 0.4,
                                  aspectRatio: 6 / 3,
                                  initialPage: 0,
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.antiAlias,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 500),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
