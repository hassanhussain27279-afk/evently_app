import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String uid;
  String id;
  String categoryId;
  String title;
  String description;
  DateTime eventDate;
  DateTime eventTime;
  List<String> favorites;
  Event({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.eventTime,
    required this.uid,
    required this.favorites,
  });
  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      uid: data?['uid'],
      id: data?['id'],
      categoryId: data?['categoryId'],
      title: data?['title'],
      description: data?['description'],
      eventDate: (data?['eventDate'] as Timestamp).toDate(),
      eventTime: (data?['eventTime'] as Timestamp).toDate(),
      favorites: (data?['favorites'] is List)
          ? (data!['favorites'] as List).map((e) => e.toString()).toList()
          : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "id": id,
      "categoryId": categoryId,
      "title": title,
      "description": description,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "favorites": favorites,
    };
  }
}
