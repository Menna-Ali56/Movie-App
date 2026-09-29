import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_details.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class CastCart extends StatefulWidget {
  final Movies movie;
  CastCart({super.key, required this.movie});

  @override
  State<CastCart> createState() => _CastCartState();
}

class _CastCartState extends State<CastCart> {
  int index = 0;

  late Future<MovieDetailsModel> movieDetails;

  @override
  void initState() {
    movieDetails = ApiMovieDetails.getDetails(widget.movie.id!, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsModel>(
        future: movieDetails,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.yellow,
            ));
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
          final cast = snap.data?.data?.movie?.cast ?? [];

          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 90,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10),
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: AppColors.darkGray.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      if (actor.urlSmallImage != null &&
                          actor.urlSmallImage!.isNotEmpty)
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          child: Image.network(
                            actor.urlSmallImage!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${actor.name ?? ''}',
                              style: AppStyles.regular14White,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Character : ${actor.characterName ?? ''}',
                              style: AppStyles.regular14White,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
