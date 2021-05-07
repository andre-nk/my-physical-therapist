part of "provider.dart";

final adminProvider = StreamProvider.family<Admin, String>((ref, adminUID){
  final adminServicesProvider = ref.watch(Provider<AdminServices>((ref) => AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
  )));
  return adminServicesProvider.adminModelGetter(adminUID);
});

final adminDataCreatorProvider = Provider<AdminServices>((ref){
  return AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
  );
});

final adminListProvider = StreamProvider.autoDispose<List<Admin>>((ref){
  final adminServicesProvider = ref.watch(Provider<AdminServices>((ref) => AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
  )));
  return adminServicesProvider.adminListGetter;
});

final userHandledProvider = StreamProvider.family<List<UserModelSimplified>, String>((ref, uid){
  final adminServicesProvider = ref.watch(Provider<AdminServices>((ref) => AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
  )));
  return adminServicesProvider.userHandledCount(uid);
});


