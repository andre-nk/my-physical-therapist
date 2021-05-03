part of "service.dart";

class ExercisesService{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ExercisesService(this._firestore, this._auth);

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

  Future<void> completeExercise(String id){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("exercises-page")
      .doc(id)
      .update({
        "isCompleted": true
      }
    );
  }

  Stream<List<ExerciseModel>> get exerciseListGetter{
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("exercises-page")
      .snapshots()
      .map(_exerciseListGetter);
  }
}