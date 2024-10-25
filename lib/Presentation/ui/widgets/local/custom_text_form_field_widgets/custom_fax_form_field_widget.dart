import 'package:crafty_bay/Presentation/ui/utils/validators/fax_number_validator.dart';
import 'package:flutter/material.dart';

class CustomFaxFormFieldWidget extends StatelessWidget {
  const CustomFaxFormFieldWidget({
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
        validator: _faxNumberValidator,
      ),
    );
  }

  String? _faxNumberValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter your fax number.";
    }
    if (!FaxNumberValidator.validateFaxNumber(value!)) {
      return "Enter a valid fax number.";
    }
    return null;
  }
}
