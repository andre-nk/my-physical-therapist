part of "model.dart";

class ExerciseModel {
  String id;
  String title;
  String comment;
  String videoURL;
  int reps;
  int rest;
  int sets;
  bool isCompleted;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.comment,
    required this.videoURL,
    required this.reps,
    required this.rest,
    required this.sets,
    required this.isCompleted
  }){
    this.id = id;
    this.title = title;
    this.comment = comment;
    this.videoURL = videoURL.substring(17, videoURL.length);
    this.reps = reps;
    this.rest = rest;
    this.sets = sets;
    this.isCompleted = isCompleted;
  }
}
