import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/ui/screens/home/tabs/movieGenre/movie_genre_screen.dart';
import 'package:movie_app/ui/widgets/genre_movie_list.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/ui/screens/home/size_config.dart';

class MovieGenre extends StatefulWidget {
  const MovieGenre({super.key});

  @override
  State<MovieGenre> createState() => _MovieGenreState();
}

class _MovieGenreState extends State<MovieGenre> {
  late Future<MovieModel> movie;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    movie = ApiMovie.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }
        if (snap.hasError) {
          return Center(
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
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        final movie = snap.data?.data?.movies ?? [];
        final genres = <String>{};
        for (var item in movie) {
          genres.addAll(item.genres ?? []);
        }
        return Padding(
          padding: SizeConfig.all(context, 8),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final currentGenre = genres.elementAt(index);

                final genreMovies = movie
                    .where((item) => item.genres?.contains(currentGenre) ?? false)
                    .toList();

                return Column(
                  children: [
                    SizedBox(height: SizeConfig.h(context, 10)),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          currentGenre,
                          style: AppStyles.regular20White,
                        )),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieGenreScreen(
                                  movies: genreMovies,
                                  genre: currentGenre,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "see more",
                            style: AppStyles.black14Yellow,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.yellow,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.h(context, 10)),
                    GenreMovieList(
                      movies: genreMovies,
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}
