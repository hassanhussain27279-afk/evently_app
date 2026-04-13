import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/core/utils/dialog_utils.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = AppLocalizations.of(context)!;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: .center,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(1000),
              child: Image.asset('assets/imageLight/image 11.png'),
            ),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? 'User',
              style: theme.textTheme.titleLarge,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? 'User@gmail.com',
              style: theme.textTheme.bodyLarge,
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.secondary.withAlpha(20),
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(l10n.darkMode),
                    Spacer(),
                    Switch(
                      value: provider.isDark,
                      onChanged: (value) {
                        provider.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.secondary.withAlpha(20),
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(l10n.english),
                    Spacer(),
                    Switch(
                      value: provider.isEn,
                      onChanged: (value) {
                        provider.toggleLocale();
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DialogUtils.buildDialog(
                  context,
                  title: l10n.logout,
                  content: l10n.logoutConfirm,
                  negActionText: l10n.ok,
                  posActionText: l10n.cancel,
                  negaction: () async {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                    await FirebaseAuth.instance.signOut();
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withAlpha(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(l10n.logout),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        DialogUtils.buildDialog(
                          context,
                          title: l10n.logout,
                          content: l10n.logoutConfirm,
                          negActionText: l10n.ok,
                          posActionText: l10n.cancel,
                          negaction: () async {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            );
                            await FirebaseAuth.instance.signOut();
                          },
                        );
                      },
                      icon: Icon(Icons.logout, color: theme.colorScheme.error),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
