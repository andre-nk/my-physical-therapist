part of "provider.dart";

final userProvider = Provider<UserService>(
  (ref) => UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ),
);

final userModelProvider = StreamProvider.family<UserModel, String>((ref, uid){
  return UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ).userModelGetter(uid);
});

final userListProvider = StreamProvider.autoDispose<List<UserModelSimplified>>((ref){
  return UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ).userListGetter;
});