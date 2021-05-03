part of "service.dart";

class GeneralContentServices{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GeneralContentServices(this._firestore, this._auth);

  GeneralContentModel _generalContentModelMapper(DocumentSnapshot doc){
    return GeneralContentModel(
      text: doc["text"],
      imageURL: doc["imageURL"] ?? ""
    );
  }

  List<dynamic> _userScaleMapper(DocumentSnapshot doc){
    List<dynamic> out = [];

    doc.data()!.forEach((key, value) {
      if(value is double){
        out.add(value.toDouble());
      } else {
        out.add(value);
      }
    });

    return out;
  }

  Future<void> userScaleSetter(String title, double value){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("general-pages")
      .doc("user-scale")
      .update({
        title: value
      });
  }

  Future<void> userPainDescriptionSetter(String description){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("general-pages")
      .doc("user-scale")
      .update({
        "description": description
      });
  }

  Stream<GeneralContentModel> generalContentModelGetter(String title){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("general-pages")
      .doc(title)
      .snapshots()
      .map(_generalContentModelMapper);
  }

  Stream<List<dynamic>> get userScaleGetter{
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("general-pages")
      .doc("user-scale")
      .snapshots()
      .map(_userScaleMapper);
  }
}