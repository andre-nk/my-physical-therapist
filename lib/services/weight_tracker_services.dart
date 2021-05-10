part of "service.dart";

class WeightTrackerServices{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WeightTrackerServices(this._firestore, this._auth);

  List<WeightValue> _weightValuesMapper(QuerySnapshot snapshot){
    List<WeightValue> out = [];

    snapshot.docs.forEach((element) {
      out.add(
        WeightValue(
          value: (element["value"]).toDouble(),
          dateTime: DateFormat("dd MMMM yyyy HH:mm").parse(element["dateTime"])
        )
      );
    });

    return out;
  }

  Stream<List<WeightValue>> get weightValuesGetter{
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("weight-tracker")
      .snapshots()
      .map(_weightValuesMapper);
  }
}