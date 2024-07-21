import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.starSize = 10,
    this.color = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: color, size: starSize));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: color, size: starSize));
    }

    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: color, size: starSize));
    }

    return Row(
      children: stars,
    );
  }
}
