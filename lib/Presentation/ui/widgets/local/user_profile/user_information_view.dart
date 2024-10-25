import 'package:crafty_bay/Presentation/ui/widgets/global/info_section_title.dart';
import 'package:crafty_bay/data/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoSectionHeader(title: "User Information"),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Name: ${user.cusName}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Address: ${user.cusAdd}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "City: ${user.cusCity}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "State: ${user.cusState}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Post Code: ${user.cusPostcode}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Country: ${user.cusCountry}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Phone: ${user.cusPhone}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Fax: ${user.cusFax}",
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoSectionHeader(title: "Shipping Information"),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Name: ${user.shipName}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Address:  ${user.shipAdd}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "City:  ${user.shipCity}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "State:  ${user.shipState}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Post Code:  ${user.shipPostcode}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Country:  ${user.shipCountry}",
              ),
              buildInfoTitle(
                textTheme: textTheme,
                title: "Phone:  ${user.shipPhone}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoTitle({
    required TextTheme textTheme,
    required String title,
  }) {
    return Text(
      title,
      style: textTheme.titleMedium,
    );
  }
}
