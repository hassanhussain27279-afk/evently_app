import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/core/utils/data_validator.dart';
import 'package:evently_app/data/firebase/firebase_auth_service.dart';
import 'package:evently_app/theme/app_colors.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const String id = 'SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordHidden = true;
  bool isPassworConfirmationdHidden = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passworConfirmationController = TextEditingController();
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
              SizedBox(height: 30),
              Text(
                localizations.createAccount,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: provider.isDark ? AppColors.inputs : AppColors.main,
                ),
              ),
              SizedBox(height: 16),
              Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      validator: (name) => DataValidator.nameValidation(
                        name ?? '',
                        localizations,
                      ),
                      autovalidateMode: .onUserInteraction,
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: localizations.enterName,
                        prefixIcon: Icon(Iconsax.user_outline),
                      ),
                    ),
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          child: Icon(
                            isPasswordHidden
                                ? Iconsax.eye_slash_outline
                                : Iconsax.eye_outline,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passworConfirmationController,
                      validator: (passworConfirmationp) =>
                          DataValidator.confirmPasswordValidation(
                            passworConfirmationp ?? '',
                            passwordController.text,
                            localizations,
                          ),
                      autovalidateMode: .onUserInteraction,
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.lock_1_outline),
                        hintText: localizations.confirmPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          child: Icon(
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
                        .createUserWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                    setState(() {
                      isLoading = false;
                    });
                    if (user?.uid != null) {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    }
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: theme.colorScheme.surface,
                      )
                    : Text(
                        localizations.signUp,
                        style: TextStyle(color: AppColors.inputs),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(localizations.alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                      child: Text(localizations.login),
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
                    Text(localizations.signUpWithGoogle),
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
