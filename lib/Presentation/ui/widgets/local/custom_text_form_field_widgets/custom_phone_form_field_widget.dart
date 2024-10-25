import 'package:crafty_bay/Presentation/ui/utils/validators/phone_number_validator.dart';
import 'package:flutter/material.dart';

class CustomPhoneFormFieldWidget extends StatelessWidget {
  const CustomPhoneFormFieldWidget({
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
        validator: _phoneNumberValidator,
      ),
    );
  }

  String? _phoneNumberValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter your phone number.";
    }
    if (!PhoneNumberValidator.validatePhoneNumber(value!)) {
      return "Enter a valid phone number.";
    }
    return null;
  }
}
