part of "model.dart";

class Admin{
  String name;
  String uid;
  String photoURL;

  Admin({required this.name, required this.uid, required this.photoURL}){
    this.name = name;
    this.uid = uid;
    this.photoURL = photoURL;
  }

  void override(){
    this.photoURL = "";
  }
}