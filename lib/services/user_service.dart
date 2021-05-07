part of "service.dart";

class UserService{
  UserService({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<void> updateUserAdminHandler(String userUID, String adminUID){
    return firestore
      .collection("users")
      .doc(userUID)
      .update({
        "adminHandler": adminUID
      }
    );
  }

  UserModel userModelMapper(DocumentSnapshot doc){
    return UserModel(
      medicationHistory: doc["medicationHistory"],
      admissionDate: DateFormat("dd MMMM yyyy HH:mm").parse(doc["admissionDate"]),
      type: doc["type"],
      informant: doc["informant"],
      illnessHistory: doc["illnessHistory"],
      diagnosis: doc["diagnosis"],
      occupation: doc["occupation"],
      sex: doc["sex"],
      age: doc["age"],
      address: doc["address"],
      pastMedicalHistory: doc["pastMedicalHistory"],
      photoURL: doc["photoURL"],
      civilStatus: doc["civilStatus"],
      adminHandler: doc["adminHandler"],
      name: doc["name"],
      nationality: doc["nationality"],
      religion: doc["religion"],
      handedness: doc["handedness"],
      complaint: doc["complaint"],
      familyHistory: doc["familyHistory"],
      caregiverGoal: doc["caregiverGoal"],
      ieDate: DateFormat("dd MMMM yyyy HH:mm").parse(doc["ieDate"]),
      ancilaryProcedure: doc["ancilaryProcedures"],
      environmentalHistory: doc["environmentalHistory"]
    );
  }

  List<UserModelSimplified> userListMapper(QuerySnapshot snapshot){
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

  Stream<UserModel> get userModelGetter{
    return firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .snapshots()
      .map(userModelMapper);
  }

  Stream<List<UserModelSimplified>> get userListGetter{
    return firestore  
      .collection("users")
      .snapshots()
      .map(userListMapper);
  }
}