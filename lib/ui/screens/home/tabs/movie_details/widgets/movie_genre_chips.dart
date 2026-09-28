import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class MovieGenreChips extends StatelessWidget {
  final List<String> genres;

  const MovieGenreChips({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.darkGray.withValues(alpha: .75),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            genre,
            style: AppStyles.regular16White,
          ),
        );
      }).toList(),
    );
  }
}
