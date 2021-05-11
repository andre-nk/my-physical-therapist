part of "provider.dart";

final chatListProvider = StreamProvider.family<List<ChatModel>, String>((ref, userUID){
  final chatServiceProvider = ref.watch(Provider<ChatServices>((ref) => ChatServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return chatServiceProvider.chatListGetter(userUID);
});

final addChatProvider = Provider.family<void, ChatModel>((ref, chat){
  final chatServiceProvider = ref.watch(Provider<ChatServices>((ref) => ChatServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  
  chatServiceProvider.chatAdder(chat.receiverUID, chat.message);
});