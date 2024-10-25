import 'package:crafty_bay/Presentation/ui/widgets/global/info_section_title.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/custom_text_form_field_widgets/custom_fax_form_field_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/custom_text_form_field_widgets/custom_phone_form_field_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/custom_text_form_field_widgets/custom_post_code_form_field_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/custom_text_form_field_widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.customerNameTEController,
    required this.customerAddressTEController,
    required this.customerCityTEController,
    required this.customerStateTEController,
    required this.customerPostCodeTEController,
    required this.customerCountryTEController,
    required this.customerPhoneTEController,
    required this.customerFaxTEController,
    required this.shippingNameTEController,
    required this.shippingAddressTEController,
    required this.shippingCityTEController,
    required this.shippingStateTEController,
    required this.shippingPostCodeTEController,
    required this.shippingCountryTEController,
    required this.shippingPhoneTEController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController customerNameTEController;
  final TextEditingController customerAddressTEController;
  final TextEditingController customerCityTEController;
  final TextEditingController customerStateTEController;
  final TextEditingController customerPostCodeTEController;
  final TextEditingController customerCountryTEController;
  final TextEditingController customerPhoneTEController;
  final TextEditingController customerFaxTEController;
  final TextEditingController shippingNameTEController;
  final TextEditingController shippingAddressTEController;
  final TextEditingController shippingCityTEController;
  final TextEditingController shippingStateTEController;
  final TextEditingController shippingPostCodeTEController;
  final TextEditingController shippingCountryTEController;
  final TextEditingController shippingPhoneTEController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoSectionHeader(title: "User Info"),
          CustomTextFormFieldWidget(
            textController: customerNameTEController,
            hintText: "Full Name",
            emptyMessage: "Name shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: customerAddressTEController,
            hintText: "Address",
            emptyMessage: "Address shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: customerCityTEController,
            hintText: "City",
            emptyMessage: "City shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: customerStateTEController,
            hintText: "State",
            emptyMessage: "State shouldn't be empty",
          ),
          CustomPostCodeFormFieldWidget(
            textController: customerPostCodeTEController,
            hintText: "Post Code",
          ),
          CustomTextFormFieldWidget(
            textController: customerCountryTEController,
            hintText: "Country",
            emptyMessage: "Country shouldn't be empty",
          ),
          CustomPhoneFormFieldWidget(
            textController: customerPhoneTEController,
            hintText: "Phone",
          ),
          CustomFaxFormFieldWidget(
            textController: customerFaxTEController,
            hintText: "Fax",
          ),
          const InfoSectionHeader(title: "Shipping Info"),
          CustomTextFormFieldWidget(
            textController: shippingNameTEController,
            hintText: "Full Name",
            emptyMessage: "Name shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: shippingAddressTEController,
            hintText: "Address",
            emptyMessage: "Address shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: shippingCityTEController,
            hintText: "City",
            emptyMessage: "City shouldn't be empty",
          ),
          CustomTextFormFieldWidget(
            textController: shippingStateTEController,
            hintText: "State",
            emptyMessage: "State shouldn't be empty",
          ),
          CustomPostCodeFormFieldWidget(
            textController: shippingPostCodeTEController,
            hintText: "Post Code",
          ),
          CustomTextFormFieldWidget(
            textController: shippingCountryTEController,
            hintText: "Country",
            emptyMessage: "Country shouldn't be empty",
          ),
          CustomPhoneFormFieldWidget(
            textController: shippingPhoneTEController,
            hintText: "Phone",
          ),
        ],
      ),
    );
  }
}
