import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/create_review/create_product_review_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/review/product_review_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/create_review/create_review_form.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/create_review/rating_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _reviewTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CreateProductReviewController _createProductReviewController =
      Get.find<CreateProductReviewController>();

  late int productID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productID = Get.arguments['productID'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            CreateReviewForm(
              formKey: _formKey,
              reviewTEController: _reviewTEController,
            ),
            const SizedBox(height: 16),
            _buildRating(),
            const SizedBox(height: 16),
            _buildOnTapSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Text(
          "Ratings: ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: GetBuilder<CreateProductReviewController>(
              builder: (createProductReviewController) {
            return RatingBarWidget(
                onUpdateRating: createProductReviewController.onUpdateRatings);
          }),
        ),
      ],
    );
  }

  Widget _buildOnTapSubmitButton() {
    return GetBuilder<CreateProductReviewController>(
        builder: (createProductReviewController) {
      return Visibility(
        visible: !createProductReviewController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapSubmitButton,
          child: const Text("Submit"),
        ),
      );
    });
  }

  Future<void> _onTapSubmitButton() async {
    if (_formKey.currentState!.validate() &&
        _createProductReviewController.ratings > 0) {
      bool isReviewCreated =
          await _createProductReviewController.createReviewAndRating(
        productDescription: _reviewTEController.text.trim(),
        productID: productID,
        rating: _createProductReviewController.ratings,
        token: AuthController.accessToken!,
      );

      if (isReviewCreated) {
        Get.find<ProductReviewController>().getListReviewByProductID(productID);
        _clearTextField();
        Get.back();
        NotificationUtils.flushBarNotification(
          title: "Congratulations",
          message: "Submitted your review",
        );
      } else {
        NotificationUtils.flushBarNotification(
          title: "Warning",
          message: "Review didn't submit! Try again.",
          backgroundColor: AppColors.redColor,
        );
      }
    } else {
      return NotificationUtils.flushBarNotification(
        title: "Warning",
        message: "You have to add both review and ratings.",
        backgroundColor: AppColors.redColor,
      );
    }
  }

  void _clearTextField() {
    _reviewTEController.clear();
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text("Create Review & Rating"),
    );
  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    super.dispose();
  }
}
