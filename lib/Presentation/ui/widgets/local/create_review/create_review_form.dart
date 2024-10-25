import 'package:crafty_bay/Presentation/ui/widgets/local/custom_text_form_field_widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class CreateReviewForm extends StatelessWidget {
  const CreateReviewForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController reviewTEController,
  })  : _formKey = formKey,
        _reviewTEController = reviewTEController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _reviewTEController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              textController: _reviewTEController,
              maxLine: 8,
              hintText: "Write your review",
              emptyMessage: "Enter your name",
            ),
          ],
        ),
      ),
    );
  }
}
