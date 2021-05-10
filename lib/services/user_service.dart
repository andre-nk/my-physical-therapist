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

  Future<void> updateUserMedicationHistory(List table, String uid){
    return firestore
      .collection("users")
      .doc(uid)
      .update({
        "medicationHistory": table
      });
  }

  Future<void> updateUserAncilaryProcedures(List table, String uid){
    return firestore
      .collection("users")
      .doc(uid)
      .update({
        "ancilaryProcedures": table
      });
  }

  Future<void> updateUserGeneralInfo(UserModel userModel, String uid){
    return firestore
      .collection("users")
      .doc(uid)
      .update({
        "environmentalHistory": userModel.environmentalHistory,
        "admissionDate": DateFormat("dd MMMM yyyy HH:mm").format(userModel.admissionDate),
        "type": userModel.type,
        "informant": userModel.informant,
        "illnessHistory": userModel.illnessHistory,
        "diagnosis": userModel.diagnosis,
        "occupation": userModel.occupation,
        "sex": userModel.sex,
        "age": userModel.age,
        "address": userModel.address,
        "pastMedicalHistory": userModel.pastMedicalHistory,
        "civilStatus": userModel.civilStatus,
        "name": userModel.name,
        "nationality": userModel.nationality,
        "religion": userModel.religion,
        "handedness": userModel.handedness,
        "complaint": userModel.complaint,
        "familyHistory": userModel.familyHistory,
        "caregiverGoal": userModel.caregiverGoal,
        "ieDate":  DateFormat("dd MMMM yyyy HH:mm").format(userModel.ieDate),
      });
  }

  Future<void> setUserGeneralInfo(UserModel userModel, String uid){
    return firestore
      .collection("users")
      .doc(uid)
      .set({
        "environmentalHistory": userModel.environmentalHistory,
        "admissionDate": DateFormat("dd MMMM yyyy HH:mm").format(userModel.admissionDate),
        "type": userModel.type,
        "informant": userModel.informant,
        "illnessHistory": userModel.illnessHistory,
        "diagnosis": userModel.diagnosis,
        "occupation": userModel.occupation,
        "sex": userModel.sex,
        "age": userModel.age,
        "address": userModel.address,
        "pastMedicalHistory": userModel.pastMedicalHistory,
        "civilStatus": userModel.civilStatus,
        "name": userModel.name,
        "nationality": userModel.nationality,
        "religion": userModel.religion,
        "handedness": userModel.handedness,
        "complaint": userModel.complaint,
        "familyHistory": userModel.familyHistory,
        "caregiverGoal": userModel.caregiverGoal,
        "ieDate":  DateFormat("dd MMMM yyyy HH:mm").format(userModel.ieDate),
        "medicationHistory": [],
        "ancilaryProcedures": [],
      });
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
      ancilaryProcedure:  doc["ancilaryProcedures"],
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

  Stream<UserModel> userModelGetter(String uid){
    return firestore
      .collection("users")
      .doc(uid)
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