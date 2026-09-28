import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  final VoidCallback onBackPressed;

  const MovieDetailsHeader({
    super.key,
    required this.movie,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 560,
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(movie.largeCoverImage ?? ""),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black2.withValues(alpha: 0.20),
                  AppColors.black2,
                ],
              ),
            ),
          ),
          Center(child: Image.asset(AppAssets.play)),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: onBackPressed,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                Image.asset(AppAssets.save),
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
                    movie.titleEnglish ?? "",
                    style: AppStyles.medium36White,
                  ),
                ),
                Text(
                  (movie.year ?? "").toString(),
                  style: AppStyles.regular20Gray,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
