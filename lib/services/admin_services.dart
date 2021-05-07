part of "service.dart";

class AdminServices{
  AdminServices({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<void> createAdminData({String? name}){
    return firestore
      .collection("admins")
      .doc(auth.currentUser!.uid)
      .set({
        "name": name ?? "",
        "profilePicture": auth.currentUser!.photoURL
      });
  }

  Admin adminModelMapper(DocumentSnapshot doc){
    return Admin(
      name: doc["name"],
      photoURL: doc["profilePicture"],
      uid: doc.id
    );
  }

  List<Admin> adminListMapper(QuerySnapshot snapshot){
    List<Admin> out = [];
    snapshot.docs.forEach((doc) {
      out.add(
        Admin(
          name: doc["name"],
          photoURL: doc["profilePicture"],
          uid: doc.id
        )
      );
    });
    return out;
  }

  List<UserModelSimplified> userHandledMapper(QuerySnapshot snapshot){
    List<UserModelSimplified> out = [];
    snapshot.docs.forEach((doc) {
      out.add(UserModelSimplified(
        uid: doc.id,
        name: doc["name"],
        adminHandler: doc["adminHandler"],
        photoURL: doc["photoURL"]
      ));
    });
    return out;
  }

  Stream<Admin> adminModelGetter(String uid){
    return firestore
      .collection("admins")
      .doc(uid)
      .snapshots()
      .map(adminModelMapper);
  }

  Stream<List<Admin>> get adminListGetter{
    return firestore
      .collection("admins")
      .snapshots()
      .map(adminListMapper);
  }

  Stream<List<UserModelSimplified>> userHandledCount(String uid){
    return firestore
      .collection("users")
      .where('adminHandler', isEqualTo: uid)
      .snapshots()
      .map(userHandledMapper);
  }
}