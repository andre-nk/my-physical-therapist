part of "model.dart";

class EventModel {
  String uid;
  String title;
  String media;
  String speaker;
  String description;
  DateTime start;
  DateTime end;

  EventModel({
    required this.uid,
    required this.title,
    required this.media,
    required this.speaker,
    required this.description,
    required this.start,
    required this.end,
  }){
    this.uid = uid;
    this.title = title;
    this.media = media;
    this.speaker = speaker;
    this.description = description;
    this.start = start;
    this.end = end;
  }
}
