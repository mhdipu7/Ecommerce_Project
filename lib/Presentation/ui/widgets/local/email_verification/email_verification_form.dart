import 'package:crafty_bay/Presentation/ui/utils/validators/email_validator.dart';
import 'package:flutter/material.dart';

class EmailVerificationForm extends StatelessWidget {
  const EmailVerificationForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEController,
  })  : _formKey = formKey,
        _emailTEController = emailTEController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTEController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            decoration: const InputDecoration(hintText: "Email"),
            validator: _emailValidation,
          ),
        ],
      ),
    );
  }

  String? _emailValidation(String? value) {
    if (value?.isEmpty ?? true) {
      return "Enter your email address";
    }
    if (!EmailValidator.validateEmail(value!)) {
      return "Enter a valid email address";
    }
    return null;
  }
}
