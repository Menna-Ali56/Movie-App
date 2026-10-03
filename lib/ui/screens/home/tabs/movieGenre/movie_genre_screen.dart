import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/ui/screens/home/size_config.dart';

class MovieGenreScreen extends StatefulWidget {
  final List<Movies> movies;
  final String genre;
  const MovieGenreScreen(
      {super.key, required this.movies, required this.genre});

  @override
  State<MovieGenreScreen> createState() => _MovieGenreScreenState();
}

class _MovieGenreScreenState extends State<MovieGenreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
            padding: SizeConfig.only(context, left: 8),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
            ),
          ),
          title: Text(
            widget.genre,
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: Padding(
          padding: SizeConfig.all(context, 8),
          child: GridView.builder(
            itemCount: widget.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.w(context, 8),
              mainAxisSpacing: SizeConfig.h(context, 12),
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: widget.movies[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
