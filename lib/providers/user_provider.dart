part of "provider.dart";

final userProvider = Provider<UserService>(
  (ref) => UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ),
);

final userModelProvider = StreamProvider.autoDispose<UserModel>((ref){
  return UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ).userModelGetter;
});

final userListProvider = StreamProvider.autoDispose<List<UserModelSimplified>>((ref){
  return UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ).userListGetter;
});