part of "provider.dart";

final adminServiceProvider = Provider<AdminServices>((ref) => AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
));

final adminProvider = StreamProvider.family<Admin, String>((ref, adminUID){
  final adminServicesProvider = ref.watch(adminServiceProvider);
  return adminServicesProvider.adminModelGetter(adminUID);
});

final adminDataCreatorProvider = Provider<AdminServices>((ref){
  return AdminServices(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider)
  );
});

final adminListProvider = StreamProvider.autoDispose<List<Admin>>((ref){
  final adminServicesProvider = ref.watch(adminServiceProvider);
  return adminServicesProvider.adminListGetter;
});

final userHandledProvider = StreamProvider.family<List<UserModelSimplified>, String>((ref, uid){
  final adminServicesProvider = ref.watch(adminServiceProvider);
  return adminServicesProvider.userHandledCount(uid);
});

final uploadAdminPhoto = FutureProvider.family<String, File>((ref, sourceFile){
  final adminServicesProvider = ref.watch(adminServiceProvider);
  return adminServicesProvider.uploadAdminPhotoURL(sourceFile);
});


