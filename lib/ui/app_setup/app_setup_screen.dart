import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/ui/app_setup/widgets/build_item_selector.dart';
import 'package:evently_app/ui/intoscreen/introscreen.dart';
import 'package:evently_app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSetupScreen extends StatelessWidget {
  const AppSetupScreen({super.key});
  static const String id = 'AppSetupScreen';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AppConfigProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/${provider.isDark ? 'logo_dark.png' : 'logo_white.png'}',
                    width: width * 0.5,
                  ),
                ],
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/${provider.isDark ? 'being-creative.png' : 'being-creativ-white.png'}',
                ),
              ),
              Text(
                localizations.personalizeExperience,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                localizations.personalizeExperienceDesc,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Text(
                    localizations.language,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  BuildItemSelector(
                    isSelected: provider.isEn,
                    onTap: () {
                      provider.changeLocale('en');
                    },
                    child: Text(
                      localizations.english,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: !provider.isEn
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  BuildItemSelector(
                    isSelected: !provider.isEn,
                    onTap: () {
                      provider.changeLocale('ar');
                    },
                    child: Text(
                      localizations.arabic,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: !provider.isEn
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    localizations.theme,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Spacer(),
                  BuildItemSelector(
                    isSelected: !provider.isDark,
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    child: SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.light_mode,
                        color: !provider.isDark
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  BuildItemSelector(
                    isSelected: provider.isDark,
                    onTap: () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                    child: SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.dark_mode,
                        color: provider.isDark
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              CustomFilledButton(
                text: localizations.letsStart,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, IntroScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
