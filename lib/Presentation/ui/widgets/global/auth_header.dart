import 'package:crafty_bay/Presentation/ui/widgets/global/app_logo_widget.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppLogoWidget(),
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black45,
              ),
        ),
      ],
    );
  }
}
