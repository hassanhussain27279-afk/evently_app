import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/data/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEventsDatabase {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference<Event> getcollectionReference() {
    return db
        .collection("events")
        .withConverter(
          fromFirestore: Event.fromFirestore,
          toFirestore: (Event event, options) => event.toFirestore(),
        );
  }

  Future<void> createEvent(Event event) async {
    var ref = getcollectionReference();
    var doc = ref.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  Stream<QuerySnapshot<Event>> getEvents(String categoryId) {
    if (categoryId == 'all') {
      return getcollectionReference().snapshots();
    } else {
      return getcollectionReference()
          .where('categoryId', isEqualTo: categoryId)
          .snapshots();
    }
  }

  Stream<QuerySnapshot<Event>> getFavoriteEvents(String categoryId) {
    var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return getcollectionReference()
        .where('favorites', arrayContains: uid)
        .where('categoryId', isEqualTo: categoryId)
        .snapshots();
  }

  Future<void> updateEvent(Event event, bool isFavorite) async {
    var ref = getcollectionReference();
    var doc = ref.doc(event.id);
    var myUid = FirebaseAuth.instance.currentUser!.uid;
    if (isFavorite) {
      event.favorites.removeWhere((element) => element == myUid);
    } else {
      event.favorites.add(myUid);
    }

    await doc.update(event.toFirestore());
  }

  Future<void> deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
  }

  Future<void> editEvent(Event event) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .update({
            'title': event.title,
            'description': event.description,
            'categoryId': event.categoryId,
            'eventDate': Timestamp.fromDate(event.eventDate),
            'eventTime': Timestamp.fromDate(event.eventTime),
            'uid': event.uid,
            'favorites': event.favorites,
          });
    } catch (e) {
      throw Exception("Error updating event: $e");
    }
  }
}
