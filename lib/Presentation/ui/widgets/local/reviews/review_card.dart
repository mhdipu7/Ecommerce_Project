import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/data/models/review/review_model.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: AppColors.whiteColor,
      elevation: 2,
      shadowColor: Colors.grey,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: const Icon(
            Icons.person_outline,
            color: Colors.grey,
          ),
        ),
        title:Text(
          review.profile!.cusName!,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.blackColor,
          ),
        ),
        subtitle: Text(
          review.description!,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
