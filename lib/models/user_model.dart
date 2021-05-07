part of "model.dart";

class UserModel{
  String name;
  String civilStatus;
  int age;
  String sex;
  String address;
  String occupation;
  String religion;
  String nationality;
  String handedness;
  String type;
  DateTime admissionDate;
  DateTime ieDate;
  String informant;
  String diagnosis;
  String complaint;
  String caregiverGoal;
  String illnessHistory;
  List<dynamic> medicationHistory; //JSON
  List<dynamic> ancilaryProcedure; //JSON
  String pastMedicalHistory;
  String familyHistory;
  String environmentalHistory;
  String photoURL;
  String adminHandler;

  UserModel({
    required this.ieDate,
    required this.name,
    required this.civilStatus,
    required this.age,
    required this.sex,
    required this.address,
    required this.occupation,
    required this.religion,
    required this.environmentalHistory,
    required this.ancilaryProcedure,
    required this.complaint,
    required this.type,
    required this.handedness,
    required this.caregiverGoal,
    required this.pastMedicalHistory,
    required this.familyHistory,
    required this.medicationHistory,
    required this.nationality,
    required this.photoURL,
    required this.diagnosis,
    required this.admissionDate,
    required this.illnessHistory,
    required this.informant,
    required this.adminHandler
  }){
    this.ieDate = ieDate;
    this.name = name;
    this.civilStatus = civilStatus;
    this.age = age;
    this.sex = sex;
    this.address = address;
    this.occupation = occupation;
    this.religion = religion;
    this.environmentalHistory = environmentalHistory;
    this.ancilaryProcedure = ancilaryProcedure;
    this.complaint = complaint;
    this.type = type;
    this.handedness = handedness;
    this.caregiverGoal = caregiverGoal;
    this.pastMedicalHistory = pastMedicalHistory;
    this.familyHistory = familyHistory;
    this.medicationHistory = medicationHistory;
    this.nationality = nationality;
    this.photoURL = photoURL;
    this.diagnosis = diagnosis;
    this.admissionDate = admissionDate;
    this.illnessHistory = illnessHistory;
    this.informant = informant;
    this.adminHandler = adminHandler;
  }
}

class UserModelSimplified{
  String uid;
  String name;
  String photoURL;
  String adminHandler;

  UserModelSimplified({required this.uid, required this.name, required this.photoURL, required this.adminHandler}){
    this.uid = uid;
    this.name = name;
    this.photoURL = photoURL;
    this.adminHandler = adminHandler;
  }
}

class MedicationHistory{
  String medications;
  String dosage;
  String indications;
  String sideEffects;

  MedicationHistory({
    required this.medications,
    required this.dosage, 
    required this.indications,
    required this.sideEffects}){
    this.medications = medications;
    this.dosage = dosage;
    this.indications = indications;
    this.sideEffects = sideEffects;
  }
}

class AncilaryProcedure{
  String ancilaryProcedure;
  String date;
  String findings;

  AncilaryProcedure({
    required this.ancilaryProcedure,
    required this.date, 
    required this.findings,
  }){
    this.ancilaryProcedure = ancilaryProcedure;
    this.date = date;
    this.findings = findings;
  }
}