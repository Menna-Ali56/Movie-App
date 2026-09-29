import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movie_suggestion_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_suggestion.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';

class MovieSimiler extends StatefulWidget {
  final int movieId;
  MovieSimiler({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieSimiler> createState() => _MovieSimilerState();
}

class _MovieSimilerState extends State<MovieSimiler> {
  late Future<MovieSuggestions> movies;
  int index = 0;
  @override
  void initState() {
    super.initState();
    movies = ApiMovieSuggestion.getApi(
      widget.movieId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movies,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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

        return Container(
            width: 170,
            child: MovieCard(
              movie: movieList[index],
            ));
      },
    );
  }
}
