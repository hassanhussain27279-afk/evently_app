import 'package:evently_app/core/l10n/app_localizations.dart';

abstract class DataValidator {
  static String? nameValidation(String name, AppLocalizations localization) {
    if (name.trim().isEmpty) {
      return localization.nameRequired;
    }

    final RegExp nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');

    if (!nameRegex.hasMatch(name)) {
      return localization.nameInvalid;
    }

    if (name.trim().length < 3) {
      return localization.nameTooShort;
    }

    return null;
  }

  static String? emailValidation(String email, AppLocalizations localization) {
    if (email.trim().isEmpty) {
      return localization.emailRequired;
    }

    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return localization.emailInvalid;
    }

    return null;
  }

  static String? passwordValidation(
    String password,
    AppLocalizations localization,
  ) {
    if (password.isEmpty) {
      return localization.passwordRequired;
    }

    if (password.length < 6) {
      return localization.passwordTooShort;
    }

    return null;
  }

  static String? confirmPasswordValidation(
    String password,
    String confirmPassword,
    AppLocalizations localization,
  ) {
    if (confirmPassword.isEmpty) {
      return localization.confirmPasswordRequired;
    }

    if (password != confirmPassword) {
      return localization.passwordsNotMatch;
    }

    return null;
  }
}
