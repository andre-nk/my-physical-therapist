part of "provider.dart";

final chatListProvider = StreamProvider.family<List<ChatModel>, String>((ref, adminUID){
  final chatServiceProvider = ref.watch(Provider<ChatServices>((ref) => ChatServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return chatServiceProvider.chatListGetter(adminUID);
});

final adminUIDProvider = StreamProvider.family<Admin, String>((ref, adminUID){
  final chatServiceProvider = ref.watch(Provider<ChatServices>((ref) => ChatServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  return chatServiceProvider.adminUIDGetter(adminUID);
});

final addChatProvider = Provider.family<void, ChatModel>((ref, chat){
  final chatServiceProvider = ref.watch(Provider<ChatServices>((ref) => ChatServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  
  chatServiceProvider.chatAdder(chat.receiverUID, chat.message);
});