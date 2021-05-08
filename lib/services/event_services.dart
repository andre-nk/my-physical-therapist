part of "service.dart";

class EventServices{
  final FirebaseFirestore _firestore;

  EventServices(this._firestore);

  Future<void> addEvent(EventModel eventModel){
    return _firestore
      .collection("events")
      .doc()
      .set({
        "description": eventModel.description,
        "end": DateFormat("dd MMMM yyyy HH:mm").format(eventModel.end),
        "start": DateFormat("dd MMMM yyyy HH:mm").format(eventModel.start),
        "media": eventModel.media,
        "speaker": eventModel.speaker,
        "title": eventModel.title
      });
  }

  Future<void> editEvent(EventModel eventModel){
    return _firestore
      .collection("events")
      .doc(eventModel.uid)
      .update({
        "description": eventModel.description,
        "end": DateFormat("dd MMMM yyyy HH:mm").format(eventModel.end),
        "start": DateFormat("dd MMMM yyyy HH:mm").format(eventModel.start),
        "media": eventModel.media,
        "speaker": eventModel.speaker,
        "title": eventModel.title
      });
  }

  Future<void> deleteEvent(String uid){
    return _firestore
      .collection("events")
      .doc(uid)
      .delete();
  }

  List<EventModel> _eventModelListMapper(QuerySnapshot snapshot){
    List<EventModel> out = [];

    snapshot.docs.forEach((element) {
      out.add(EventModel(
        uid: element.id,
        title: element["title"],
        start: DateFormat("dd MMMM yyyy HH:mm").parse(element["start"]),
        end: DateFormat("dd MMMM yyyy HH:mm").parse(element["end"]),
        media: element["media"],
        description: element["description"],
        speaker: element["speaker"]
      ));
    });

    return out;
  }

  Stream<List<EventModel>> get eventModelList{
    return _firestore
      .collection("events")
      .snapshots()
      .map(_eventModelListMapper);
  }
}