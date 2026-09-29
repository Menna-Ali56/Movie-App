import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class MovieStatButton extends StatelessWidget {
  final String assetPath;
  final String value;
  final double horizontalPadding;
  final double iconSpacing;
  final EdgeInsetsGeometry? margin;

  const MovieStatButton({
    super.key,
    required this.assetPath,
    required this.value,
    this.horizontalPadding = 10,
    this.iconSpacing = 10,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(left: 12, right: 12),
      child: CustomElevatedButton(
        backgroundColor: AppColors.darkGray,
        verticalPadding: 10,
        horizontalPadding: horizontalPadding,
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(assetPath),
            SizedBox(width: iconSpacing),
            Text(
              value,
              style: AppStyles.regular20White,
            ),
          ],
        ),
      ),
    );
  }
}
