import 'package:evently_app/ui/event_mangment/event_mangnment.dart';
import 'package:evently_app/ui/home/tabs/fav/favorites_tabs.dart';
import 'package:evently_app/ui/home/tabs/home/home_tabs.dart';
import 'package:evently_app/ui/home/tabs/profile/profile_tabs.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTabs(), FavoritesTabs(), ProfileTabs()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, EventMangnment.id);
          },
          elevation: 0,
          child: Icon(Icons.add),
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),

        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },

            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.home_bold),
                icon: Icon(Iconsax.home_outline),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.heart_bold),
                icon: Icon(Iconsax.heart_outline),
                label: l10n.favorites,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Iconsax.user_bold),
                icon: Icon(Iconsax.user_outline),
                label: l10n.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
