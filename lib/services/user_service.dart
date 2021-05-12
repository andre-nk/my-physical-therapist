part of "service.dart";

class UserService{
  UserService({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> createUserData({String? name}){
    return firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .set({
        "name": name ?? "",
        "photoURL": auth.currentUser!.uid,
        "adminHandler": ""
      });
  }

  Future<String> uploadAdminPhotoURL(File sourceFile) async {

    String uid = auth.currentUser!.uid;
    String out = "";

    try {
      await storage
        .ref('users/$uid-profile.png')
        .putFile(sourceFile);

      out = await storage.ref('users/$uid-profile.png').getDownloadURL();

    } on FirebaseException catch (e) {
      print(e);
    }

    return out;
  }

  Future<void> updateProfilePicture(User user, String downloadURL) async {
    user.updateProfile(
      photoURL: downloadURL
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

  Stream<UserModel> get userModelGetter{
    return firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .snapshots()
      .map(userModelMapper);
  }
}