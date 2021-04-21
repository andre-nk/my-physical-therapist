part of "provider.dart";

final userProvider = ChangeNotifierProvider<UserService>(
  (ref) => UserService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider)
  ),
);