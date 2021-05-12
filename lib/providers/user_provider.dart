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

final uploadUserPhoto = FutureProvider.family<String, File>((ref, sourceFile){
  return ref.watch(userProvider).uploadAdminPhotoURL(sourceFile);
});