part of "service.dart";

class GeneralContentServices{
  final FirebaseFirestore _firestore;

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  GeneralContentServices(this._firestore);

  GeneralContentModel _generalContentModelMapper(DocumentSnapshot doc){
    return GeneralContentModel(
      text: doc["text"],
      imageURL: doc["imageURL"] ?? ""
    );
  }

  Future<String> uploadContentPhotoURL(File sourceFile) async {

    String uid = Uuid().v1();
    String out = "";
    
    try {
      await storage
        .ref('general-content/$uid.png')
        .putFile(sourceFile);

      out = await storage.ref('general-content/$uid.png').getDownloadURL();

    } on FirebaseException catch (e) {
      print(e);
    }

    return out;
  }

  Future<void> generalContentEditor(GeneralContentModel model, String uid, String type){
    return 
      _firestore
        .collection('users')
        .doc(uid)
        .collection("general-pages")
        .doc(type)
        .get().then((value) async {
          if(!(value.exists)){
            _firestore
              .collection("users")
              .doc(uid)
              .collection("general-pages")
              .doc(type)
              .set({
                "text": model.text,
                "imageURL": model.imageURL
              });
          } else {
            _firestore
              .collection("users")
              .doc(uid)
              .collection("general-pages")
              .doc(type)
              .update({
                "text": model.text,
                "imageURL": model.imageURL
              });
          }
      }
    );
  }

  List<dynamic> _userScaleMapper(DocumentSnapshot doc){
    List<dynamic> out = [];

    if(doc.data() != null){
      print("aaaa");
      doc.data()!.forEach((key, value) {
        if(value is double){
          out.add(value.toDouble());
        } else {
          out.add(value);
        }
      });
    }

     print("bbbb");

    return out;
  }

  Stream<GeneralContentModel> generalContentModelGetter(List<String> params){
    return _firestore
      .collection("users")
      .doc(params[0])
      .collection("general-pages")
      .doc(params[1])
      .snapshots()
      .map(_generalContentModelMapper);
  }

  Stream<List<dynamic>> userScaleGetter(String uid){
    return _firestore
      .collection("users")
      .doc(uid)
      .collection("general-pages")
      .doc("user-scale")
      .snapshots()
      .map(_userScaleMapper);
  }
}