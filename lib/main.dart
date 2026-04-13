import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/theme/app_theme.dart';
import 'package:evently_app/core/utils/Shared_Preferences_keys.dart';
import 'package:evently_app/ui/app_setup/app_setup_screen.dart';
import 'package:evently_app/ui/event_mangment/event_details.dart';
import 'package:evently_app/ui/event_mangment/event_edit.dart';
import 'package:evently_app/ui/event_mangment/event_mangnment.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/intoscreen/introscreen.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:evently_app/ui/sign_up/sign_up.dart';
import 'package:evently_app/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(EventlyApp());
}

class EventlyApp extends StatefulWidget {
  const EventlyApp({super.key});

  @override
  State<EventlyApp> createState() => _EventlyAppState();
}

class _EventlyAppState extends State<EventlyApp> {
  late AppConfigProvider provider;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppConfigProvider>(
      create: (_) => AppConfigProvider(),
      child: Consumer<AppConfigProvider>(
        builder: (context, provider, _) {
          this.provider = provider;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale(provider.locale),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            themeMode: provider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            initialRoute: SplashScreen.id,

            routes: {
              SplashScreen.id: (_) => const SplashScreen(),
              AppSetupScreen.id: (_) => const AppSetupScreen(),
              IntroScreen.id: (_) => IntroScreen(),
              LoginScreen.id: (_) => LoginScreen(),
              SignUp.id: (_) => SignUp(),
              HomeScreen.id: (_) => HomeScreen(),
              EventMangnment.id: (_) => EventMangnment(),
              EventEdit.id: (context) {
                var event = ModalRoute.of(context)?.settings.arguments as Event;
                return EventEdit(event: event);
              },
              EventDetails.id: (context) {
                var event = ModalRoute.of(context)?.settings.arguments as Event;
                return EventDetails(event: event);
              },
            },
          );
        },
      ),
    );
  }

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    var isDark = prefs.getBool(SharedPreferencesKeys.isDark.name) ?? false;
    var locale = prefs.getString(SharedPreferencesKeys.local.name) ?? 'en';
    provider.changeTheme(isDark ? ThemeMode.dark : ThemeMode.light);
    provider.changeLocale(locale);
  }
}
