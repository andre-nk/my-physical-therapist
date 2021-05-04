part of "service.dart";

class ChatServices{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatServices(this._firestore, this._auth);

  List<ChatModel> _chatListMapper(QuerySnapshot snapshot){
    List<ChatModel> out = [];
    snapshot.docs.forEach((element) {
      out.add(ChatModel(
        uid: element.id,
        senderUID: element["senderUID"],
        receiverUID: element["receiverUID"],
        dateTime: DateFormat("dd MMMM yyyy HH:mm").parse(element["dateTime"]),
        message: element["message"]
      ));
    });
    return out;
  }

  Future<void> chatAdder(String receiverUID, String message){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("chats")
      .doc()
      .set({
        "receiverUID": receiverUID,
        "senderUID": _auth.currentUser!.uid,
        "message": message,
        "dateTime": DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now())
      });
  }

  Stream<List<ChatModel>> chatListGetter (String adminUID){
    return _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("chats")
      .snapshots()
      .map(_chatListMapper);
  }

  Stream<Admin> adminUIDGetter (String adminUID){
    return _firestore
      .collection("admins")
      .doc(adminUID)
      .snapshots()
      .map((event){
        return Admin( //TBA FOR PROFILE PICTURE
          name: event["name"],
          uid: event.id
        );
      });
  }
}