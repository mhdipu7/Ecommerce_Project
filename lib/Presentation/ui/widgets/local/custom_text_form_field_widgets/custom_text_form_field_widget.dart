import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required TextEditingController textController,
    required String hintText,
    required String emptyMessage,
    int? maxLine = 1,
  })  : _textController = textController,
        _hintText = hintText,
        _emptyMessage = emptyMessage,
        _maxLine = maxLine;

  final TextEditingController _textController;
  final String _hintText;
  final String _emptyMessage;
  final int? _maxLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        maxLines: _maxLine,
        controller: _textController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(hintText: _hintText),
        validator: _textValidator,
      ),
    );
  }

  String? _textValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return _emptyMessage;
    }
    return null;
  }
}
