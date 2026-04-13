import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/ui/app_setup/widgets/build_item_selector.dart';
import 'package:evently_app/ui/intoscreen/models/onboarding_model.dart';
import 'package:evently_app/ui/intoscreen/widgets/dot_indicator.dart';
import 'package:evently_app/ui/intoscreen/widgets/onboarding_page.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:evently_app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String id = 'IntroScreen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var loc = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Visibility(
          visible: _currentPage > 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: IconButton(
              color: provider.isDark
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary,
              onPressed: () {
                if (_currentPage > 0) {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        title: Center(
          child: Image.asset(
            'assets/images/${provider.isDark ? 'logo_dark.png' : 'logo_white.png'}',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Visibility(
              visible: _currentPage != OnboardingModel.boards.length - 1,
              child: IconButton(
                onPressed: () {
                  pageController.jumpToPage(OnboardingModel.boards.length - 1);
                },
                icon: Text(
                  getTranslatedText(loc, 'skip_button'),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: provider.isDark
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            Expanded(
              flex: 6,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: OnboardingModel.boards.length,
                itemBuilder: (context, Index) {
                  return OnboardingPage(
                    onboardingModel: OnboardingModel.boards[Index],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardingModel.boards.length,
                (index) =>
                    DotIndicator(index: index, currentIndex: _currentPage),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    getTranslatedText(
                      loc,
                      OnboardingModel.boards[_currentPage].title,
                    ),
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  Text(
                    getTranslatedText(
                      loc,
                      OnboardingModel.boards[_currentPage].description,
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            CustomFilledButton(
              text: _currentPage == OnboardingModel.boards.length - 1
                  ? getTranslatedText(loc, 'letsStart')
                  : getTranslatedText(loc, 'next_button'),

              onPressed: () {
                if (_currentPage == OnboardingModel.boards.length - 1) {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                } else {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String getTranslatedText(AppLocalizations loc, String key) {
    final Map<String, String> translations = {
      "findEventsThatInspireYou": loc.findEventsThatInspireYou,
      "findEventsThatInspireYouDescription":
          loc.findEventsThatInspireYouDescription,
      "effortless_event_planning_title": loc.effortless_event_planning_title,
      "effortless_event_planning_description":
          loc.effortless_event_planning_description,
      "connect_with_friends_title": loc.connect_with_friends_title,
      "connect_with_friends_description": loc.connect_with_friends_description,
      "skip_button": loc.skip_button,
      "next_button": loc.next_button,
      "letsStart": loc.letsStart,
    };

    return translations[key] ?? "";
  }
}
