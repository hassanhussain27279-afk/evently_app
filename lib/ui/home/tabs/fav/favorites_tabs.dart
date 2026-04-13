import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/data/firebase/firebase_events_database.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:evently_app/ui/home/tabs/home/widget/event_card.dart';
import 'package:flutter/material.dart';

class FavoritesTabs extends StatelessWidget {
  FavoritesTabs({super.key});
  FirebaseEventsDatabase database = FirebaseEventsDatabase();
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: database.getFavoriteEvents(''),
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
    );
  }
}
