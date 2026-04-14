import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/data/firebase/firebase_events_database.dart';
import 'package:evently_app/data/models/category.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/ui/home/tabs/home/widget/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  FirebaseEventsDatabase database = FirebaseEventsDatabase();
  List<Category> categories = [];
  late Category selectedCategory;
  @override
  void initState() {
    super.initState();
    categories.add(
      Category(
        nameEn: 'ALL',
        nameAr: 'الكل',
        id: 'all',
        imageDark: '',
        imageLight: '',
        icon: Iconsax.category_bold,
      ),
    );
    categories.addAll(allCategories.values.toList());
    selectedCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Text(l10n.welcomeBack, style: theme.textTheme.bodyLarge),
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          l10n.user,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.toggleTheme();
                },
                child: Icon(
                  provider.isDark ? Icons.dark_mode : Icons.light_mode,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  provider.toggleLocale();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    provider.isEn ? l10n.en : l10n.ar,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(0, 80),
            child: _buildCategoriesTabBar(context, provider),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Event>>(
          stream: database.getEvents(selectedCategory.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              var events =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
              if (events.isEmpty) {
                return Center(child: Text(l10n.noEventsFound));
              } else {
                return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: events.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return EventCard(event: events[index]);
                  },
                );
              }
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  DefaultTabController _buildCategoriesTabBar(
    BuildContext context,
    AppConfigProvider provider,
  ) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        isScrollable: true,
        tabAlignment: .start,
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        padding: .symmetric(horizontal: 12),
        labelPadding: .all(4),
        onTap: (value) {
          setState(() {
            selectedCategory = categories[value];
          });
        },
        tabs: categories
            .map(
              (category) => Container(
                padding: .symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: category.id == selectedCategory.id
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSecondary.withAlpha(20),
                  ),
                  color: category.id == selectedCategory.id
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      category.icon,
                      color: category.id == selectedCategory.id
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      provider.isEn ? category.nameEn : category.nameAr,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: category.id == selectedCategory.id
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
