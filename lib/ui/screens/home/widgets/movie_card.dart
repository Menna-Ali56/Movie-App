import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/tabs/movie_details/movie_details_screen.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    final String posterImage = movie.mediumCoverImage ?? '';

    return Material(
      color: AppColors.transparentColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movie: movie),
              ));
        },
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: posterImage.isEmpty
                  ? const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                    )
                  : Image.network(
                      posterImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 28,
              width: 58,
              decoration: BoxDecoration(
                color: AppColors.darkGray.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      movie.rating?.toString() ?? '0.0',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Image.asset(
                    AppAssets.star,
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
