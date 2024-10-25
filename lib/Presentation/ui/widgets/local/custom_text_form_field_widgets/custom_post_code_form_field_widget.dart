import 'package:crafty_bay/Presentation/ui/utils/validators/post_code_validator.dart';
import 'package:flutter/material.dart';

class CustomPostCodeFormFieldWidget extends StatelessWidget {
  const CustomPostCodeFormFieldWidget({
    super.key,
    required TextEditingController textController,
    required String hintText,
  })  : _textController = textController,
        _hintText = hintText;

  final TextEditingController _textController;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: _textController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(hintText: _hintText),
        validator: _postCodeValidator,
      ),
    );
  }

  String? _postCodeValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter your post code.";
    }
    if (!PostCodeValidator.validatePostCode(value!)) {
      return "Enter a valid post code.";
    }
    return null;
  }
}
