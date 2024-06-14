import 'package:flutter/material.dart';

class FiveStarRating extends StatelessWidget {
  final double rating; // Integer rating, expecting values 1 through 5
  static const double iconSize = 20;

  // Constructor takes a required rating parameter
  const FiveStarRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: iconSize,
        );
      }),
    );
  }
}
