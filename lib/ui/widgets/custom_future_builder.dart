import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';

class CustomFutureBuilder extends StatefulWidget {
  Function? onChangeImage;
  bool autoPlay;
  bool enlargeCenterPage;
  double aspectRatio;
  List<Movies>? movieList;
  CustomFutureBuilder({
    super.key,
    this.onChangeImage,
    this.autoPlay = false,
    this.enlargeCenterPage = false,
    this.aspectRatio = 8 / 6,
    this.movieList,
  });

  @override
  State<CustomFutureBuilder> createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
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
    return FutureBuilder(
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
          return Column(children: [
            CarouselSlider.builder(
              itemCount: movieList.length,
              itemBuilder: (context, index, realIndex) {
                final movie = movieList[index];
                return MovieCard(movie: movie);
              },
              options: CarouselOptions(
                autoPlay: widget.autoPlay,
                enlargeCenterPage: widget.enlargeCenterPage,
                viewportFraction: 0.5,
                aspectRatio: widget.aspectRatio,
                initialPage: 0,
                clipBehavior: Clip.antiAlias,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 500),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                  widget.onChangeImage
                      ?.call(movieList[index].largeCoverImage ?? "");
                },
              ),
            ),
          ]);
        });
  }
}
