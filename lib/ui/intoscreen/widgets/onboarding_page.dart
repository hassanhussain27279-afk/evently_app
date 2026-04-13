import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/ui/intoscreen/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${provider.isDark ? onboardingModel.darkImage : onboardingModel.lightImage}',
            ),
          ],
        ),
      ],
    );
  }
}
