import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/core/utils/data_validator.dart';
import 'package:evently_app/data/firebase/firebase_auth_service.dart';
import 'package:evently_app/theme/app_colors.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(
                      'assets/images/${provider.isDark ? 'logo_dark.png' : 'logo_white.png'}',
                    ),
                  ],
                ),
              ),
              Text(
                localizations.loginTitle,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: provider.isDark ? AppColors.inputs : AppColors.main,
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (email) => DataValidator.emailValidation(
                        email ?? '',
                        localizations,
                      ),
                      autovalidateMode: .onUserInteraction,
                      decoration: InputDecoration(
                        hintText: localizations.enterEmail,
                        prefixIcon: Icon(Iconsax.sms_outline),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (password) => DataValidator.passwordValidation(
                        password ?? '',
                        localizations,
                      ),
                      autovalidateMode: .onUserInteraction,
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.lock_1_outline),
                        hintText: localizations.passwordHint,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          icon: Icon(
                            isPasswordHidden
                                ? Iconsax.eye_slash_outline
                                : Iconsax.eye_outline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: .end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(localizations.forgetPassword),
                  ),
                ],
              ),
              SizedBox(height: 40),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 0),
                ),
                onPressed: () async {
                  if (isLoading) return;
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseAuthService firebaseAuthService =
                        FirebaseAuthService();
                    var user = await firebaseAuthService
                        .signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                    setState(() {
                      isLoading = false;
                    });
                    if (user?.uid != null) {
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                    }
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: theme.colorScheme.surface,
                      )
                    : Text(
                        localizations.loginButton,
                        style: TextStyle(color: AppColors.inputs),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(localizations.noAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignUp.id);
                      },
                      child: Text(localizations.signup),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: theme.colorScheme.secondary.withAlpha(40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      localizations.or,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: AppColors.main,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: theme.colorScheme.secondary.withAlpha(40),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var user = await FirebaseAuthService().signInWithGoogle();
                  if (user?.user != null) {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  } else {
                    print("Login cancelled");
                  }
                },
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: 20,
                  children: [
                    Brand(Brands.google),
                    Text(localizations.loginWithGoogle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
