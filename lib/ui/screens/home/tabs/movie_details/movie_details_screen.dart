import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_details.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future movieDetails;
  int index = 0;
  initState() {
    movieDetails = ApiMovieDetails.getDetails(10);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          FutureBuilder(
            future: movieDetails,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
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
              return Column(
                children: [],
              );
            },
          )
        ],
      )
    ]);
  }
}
