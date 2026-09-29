import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_details.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/movie_similer.dart';
import 'package:movie_app/ui/screens/home/widgets/cast_cart.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/widgets/movie_details_header.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/widgets/movie_details_section_title.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/widgets/movie_genre_chips.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/widgets/movie_stat_button.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/utils/firebase_utils.dart';
class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsModel> movieDetails;

  @override
  void initState() {
    super.initState();
    movieDetails = ApiMovieDetails.getDetails(widget.movie.id!, true);
    _addToHistory();

  }
  Future<void> _addToHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    await FireBaseUtils.addMovieToHistory(
      userId: user.uid,
      movie: widget.movie,
    );
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
                return _buildLoadingState();
              }
              if (snap.hasError) {
                return _buildErrorState();
              }
              if (snap.data?.status != 'ok') {
                return _buildStatusState(snap);
              }

              final movie = snap.data!;
              final detailMovie = movie.data?.movie;
              if (detailMovie == null) {
                return _buildErrorState();
              }

              return Column(
                children: [
                  MovieDetailsHeader(
                    movie: detailMovie,
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: AppColors.red,
                            verticalPadding: 10,
                            onPressed: () {},
                            child: Text(
                              'Watch',
                              style: AppStyles.regular20White,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MovieStatButton(
                        assetPath: AppAssets.favorite,
                        value: (detailMovie.likeCount ?? '').toString(),
                        horizontalPadding: 10,
                        iconSpacing: 10,
                      ),
                      MovieStatButton(
                        assetPath: AppAssets.time,
                        value: (detailMovie.runtime ?? '').toString(),
                        horizontalPadding: 15,
                        iconSpacing: 15,
                      ),
                      MovieStatButton(
                        assetPath: AppAssets.star2,
                        value: (detailMovie.rating ?? '').toString(),
                        horizontalPadding: 10,
                        iconSpacing: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const MovieDetailsSectionTitle(
                    title: 'Screen Shots',
                    padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      detailMovie.backgroundImage ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const MovieDetailsSectionTitle(
                    title: 'Similar ',
                    padding: EdgeInsets.only(left: 10, top: 15, bottom: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 10,
                      bottom: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MovieSimiler(movieId: widget.movie.id!),
                      ],
                    ),
                  ),
                  const MovieDetailsSectionTitle(
                    title: 'Summary ',
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 12, left: 12, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          detailMovie.descriptionIntro ?? '',
                          style: AppStyles.regular16White,
                        ),
                      ],
                    ),
                  ),
                  const MovieDetailsSectionTitle(
                    title: 'Cast',
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 10,
                      bottom: 5,
                    ),
                    child: CastCart(movie: widget.movie),
                  ),
                  const MovieDetailsSectionTitle(
                    title: 'Genres',
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 5,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: MovieGenreChips(genres: detailMovie.genres ?? []),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.yellow,
      ),
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Text(
        'Something went wrong',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildStatusState(AsyncSnapshot<MovieDetailsModel> snap) {
    return Center(
      child: Text(
        snap.data?.statusMessage ?? '',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
