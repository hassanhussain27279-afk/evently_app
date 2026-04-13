import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/core/utils/dialog_utils.dart';
import 'package:evently_app/data/firebase/firebase_events_database.dart';
import 'package:evently_app/data/models/category.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/ui/event_mangment/event_edit.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/home/tabs/home/home_tabs.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  EventDetails({super.key, required this.event});
  static const String id = '/EventDetails';
  final Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  FirebaseEventsDatabase database = FirebaseEventsDatabase();

  late Category selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = allCategories[widget.event.categoryId]!;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var theme = Theme.of(context);
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localizations.eventDetails),
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EventEdit.id,
                arguments: widget.event,
              );
            },
            icon: Icon(Iconsax.edit_outline),
          ),
          IconButton(
            onPressed: () async {
              DialogUtils.buildDialog(
                context,
                title: localizations.deleteEvent,
                content: localizations.deleteEventConfirm,
                negActionText: localizations.ok,
                posActionText: localizations.cancel,
                negaction: () async {
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                  await database.deleteEvent(widget.event.id);
                },
              );
            },
            icon: Icon(Iconsax.trash_outline, color: theme.colorScheme.error),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(80),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    !provider.isDark
                        ? selectedCategory.imageLight
                        : selectedCategory.imageDark,
                    width: double.infinity,
                    fit: .cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                widget.event.title,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: theme.colorScheme.primary.withAlpha(20),
                      ),
                      child: Icon(
                        Iconsax.calendar_add_outline,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: .center,
                        spacing: 8,
                        children: [
                          Text(
                            DateFormat(
                              "dd MMMM",
                            ).format(widget.event.eventDate),
                            style: theme.textTheme.titleMedium!.copyWith(),
                          ),
                          Text(
                            DateFormat(
                              "hh:mm a",
                            ).format(widget.event.eventTime),
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                localizations.description,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.event.description,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
