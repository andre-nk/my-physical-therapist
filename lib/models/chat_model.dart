part of "model.dart";

class ChatModel{
  String uid;
  String senderUID;
  String receiverUID;
  String message;
  DateTime dateTime;

  ChatModel({
    required this.uid,
    required this.senderUID,
    required this.receiverUID,
    required this.message,
    required this.dateTime
  }){
    this.uid = uid;
    this.senderUID = senderUID;
    this.receiverUID = receiverUID;
    this.message = message;
    this.dateTime = dateTime;
  }
}