part of "provider.dart";

final authenticationProvider = ChangeNotifierProvider<AuthenticationService>(
  (ref) => AuthenticationService(auth: ref.watch(firebaseAuthProvider)),
);
