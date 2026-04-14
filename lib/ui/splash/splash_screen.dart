import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/ui/app_setup/app_setup_screen.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        user != null ? HomeScreen.id : AppSetupScreen.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(),
            Expanded(
              child: Image.asset(
                'assets/images/${provider.isDark ? 'Evently_dark.png' : 'Evently.png'}',
                width: width * 0.8,
              ),
            ),
            Image.asset(
              'assets/images/${provider.isDark ? 'Logo_splash_d.png' : 'Logo.png'}',
              width: width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
