import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_details.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/movie_similer.dart';
import 'package:movie_app/ui/screens/home/widgets/cast_cart.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsModel> movieDetails;
  int index = 0;

  @override
  void initState() {
    movieDetails = ApiMovieDetails.getDetails(widget.movie.id!, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        body: SingleChildScrollView(
          child: FutureBuilder<MovieDetailsModel>(
            future: movieDetails,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow,
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
              final movie = snap.data!;
              return Column(
                children: [
                  Container(
                    height: 560,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Stack(
                      children: [
                        Image.network(movie.data?.movie?.largeCoverImage ?? ""),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.black2.withValues(alpha: 0.20),
                              AppColors.black2,
                            ],
                          )),
                        ),
                        Center(child: Image.asset(AppAssets.play)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                              ),
                              Spacer(),
                              Image.asset(AppAssets.save)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  movie.data?.movie?.titleEnglish ?? "",
                                  style: AppStyles.medium36White,
                                ),
                              ),
                              Text(
                                (movie.data?.movie?.year ?? "").toString(),
                                style: AppStyles.regular20Gray,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                              backgroundColor: AppColors.red,
                              verticalPadding: 10,
                              onPressed: () {},
                              child: Text(
                                'Watch',
                                style: AppStyles.regular20White,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: CustomElevatedButton(
                            backgroundColor: AppColors.darkGray,
                            verticalPadding: 10,
                            horizontalPadding: 10,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(AppAssets.favorite),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  (movie.data?.movie?.likeCount ?? "")
                                      .toString(),
                                  style: AppStyles.regular20White,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: CustomElevatedButton(
                            backgroundColor: AppColors.darkGray,
                            verticalPadding: 10,
                            horizontalPadding: 15,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(AppAssets.time),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  (movie.data?.movie?.runtime ?? "").toString(),
                                  style: AppStyles.regular20White,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: CustomElevatedButton(
                            backgroundColor: AppColors.darkGray,
                            verticalPadding: 10,
                            horizontalPadding: 10,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(AppAssets.star2),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  (movie.data?.movie?.rating ?? "").toString(),
                                  style: AppStyles.regular20White,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Screen Shots",
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      movie.data?.movie?.backgroundImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Similar ",
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12, left: 12, top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MovieSimiler(
                          movieId: widget.movie.id!,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Summary ",
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 12, left: 12, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          movie.data?.movie?.descriptionIntro ?? "",
                          style: AppStyles.regular16White,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Cast",
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 5),
                    child: CastCart(
                      movie: widget.movie,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Genres",
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12, left: 12, top: 5, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                (movie.data?.movie?.genres! ?? []).map((genre) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.darkGray.withValues(alpha: .75),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  genre,
                                  style: AppStyles.regular16White,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
