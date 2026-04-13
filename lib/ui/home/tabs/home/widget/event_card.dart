import 'package:evently_app/core/providers/app_config_provider.dart';
import 'package:evently_app/data/firebase/firebase_events_database.dart';
import 'package:evently_app/data/models/category.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/ui/event_mangment/event_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  late Category category;
  FirebaseEventsDatabase database = FirebaseEventsDatabase();
  EventCard({super.key, required this.event}) {
    category = allCategories[event.categoryId]!;
  }
  final Event event;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EventDetails.id, arguments: event);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                provider.isDark ? category.imageDark : category.imageLight,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Container(
                  padding: .symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat("dd MMM").format(event.eventDate),
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Container(
                  padding: .symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          database.updateEvent(
                            event,
                            event.favorites.contains(
                              FirebaseAuth.instance.currentUser?.uid ?? '',
                            ),
                          );
                        },
                        child: Icon(
                          event.favorites.contains(
                                FirebaseAuth.instance.currentUser!.uid,
                              )
                              ? Iconsax.heart_bold
                              : Iconsax.heart_outline,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
