part of "service.dart";

class UserService extends ChangeNotifier{
  UserService({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<void> createUserData(String uid, {String? name}){
    return firestore
      .collection("users")
      .doc(uid)
      .set({
        "name": name ?? ""
      });
  }
}