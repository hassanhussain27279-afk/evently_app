import 'package:evently_app/core/theme/app_theme.dart';
import 'package:evently_app/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      initialRoute: SplashScreen.id,
      routes: {SplashScreen.id: (context) => SplashScreen()},
    );
  }
}
