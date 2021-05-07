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

  List<EventModel> _eventModelListMapper(QuerySnapshot snapshot){
    List<EventModel> out = [];

    snapshot.docs.forEach((element) {
      out.add(EventModel(
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