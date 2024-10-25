import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.onUpdateRating,
  });

  final Function(double) onUpdateRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      minRating: 0,
      maxRating: 5,
      initialRating: 0,
      ratingWidget: RatingWidget(
        full: _buildRatingIcon(),
        half: _buildRatingIcon(Colors.amber.shade200),
        empty: _buildRatingIcon(Colors.grey),
      ),
      onRatingUpdate: onUpdateRating,
    );
  }

  Widget _buildRatingIcon([Color color = Colors.amber]) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}
