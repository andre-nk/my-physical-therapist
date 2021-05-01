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

  Stream<GeneralContentModel> generalContentModelGetter(String title){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("general-pages")
      .doc(title)
      .snapshots()
      .map(_generalContentModelMapper);
  }
}