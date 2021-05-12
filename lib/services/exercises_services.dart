part of "service.dart";

class ExercisesService{
  final FirebaseFirestore _firestore;

  ExercisesService(this._firestore);

  List<ExerciseModel> _exerciseListGetter(QuerySnapshot snapshot){
    List<ExerciseModel> out = [];

    snapshot.docs.forEach((doc) {
      out.add(ExerciseModel(
        id: doc.id,
        title: doc["title"],
        comment: doc["comment"],
        videoURL: doc["videoURL"],
        sets: doc["sets"],
        reps: doc["reps"],
        rest: doc["rest"],
        isCompleted: doc["isCompleted"]
      ));
    });

    return out;
  }

  Future<void> addExercise({
    required String uid,
    required String title,
    required String videoURL,
    required String comment,
    required bool isCompleted,
    required int reps,
    required int rest,
    required int sets
  }){
    return _firestore
      .collection("users")
      .doc(uid)
      .collection("exercises-page")
      .doc()
      .set({
        "comment": comment,
        "isCompleted": isCompleted,
        "reps": reps,
        "rest": reps,
        "sets": sets,
        "title": title,
        "videoURL": videoURL
      });
  }

  Future<void> updateExercise({
    required String uid,
    required String id,
    required String title,
    required String videoURL,
    required String comment,
    required bool isCompleted,
    required int reps,
    required int rest,
    required int sets
  }){
    return _firestore
      .collection("users")
      .doc(uid)
      .collection("exercises-page")
      .doc(id)
      .update({
        "comment": comment,
        "isCompleted": isCompleted,
        "reps": reps,
        "rest": reps,
        "sets": sets,
        "title": title,
        "videoURL": videoURL
      });
  }

  Future<void> deleteExercise({
    required String uid,
    required String id,
  }){
    return _firestore
      .collection("users")
      .doc(uid)
      .collection("exercises-page")
      .doc(id)
      .delete();
  }

  void deleteExercises({
    required String uid,
  }){
    _firestore.collection('users').doc(uid).collection("exercises-page").snapshots().map((snapshot){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

  Stream<List<ExerciseModel>> exerciseListGetter (String uid){
    return _firestore
      .collection("users")
      .doc(uid)
      .collection("exercises-page")
      .snapshots()
      .map(_exerciseListGetter);
  }
}