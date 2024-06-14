import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/five_star_rating.dart';

class ReviewCard extends StatefulWidget {
  final String ReviewerName;
  final String ReviewTitle;
  final String Review;
  final double ReviewRating;
  const ReviewCard({
    super.key,
    required this.ReviewerName,
    required this.ReviewTitle,
    required this.Review,
    required this.ReviewRating,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    String defaultIcon = 'assets/images/default-profile.png';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.all(10.0),
      width: 320, // Keeps width constant
      decoration: ShapeDecoration(
        color: Color.fromARGB(255, 246, 126, 210),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Important to let Column size to its children
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(defaultIcon, width: 55),
              const SizedBox(width: 20),
              Expanded(
                // Wrap in Expanded to avoid overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ReviewerName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.ReviewTitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    FiveStarRating(rating: widget.ReviewRating),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.Review,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            overflow: TextOverflow.clip, // Allow text to wrap and expand
          ),
        ],
      ),
    );
  }
}
