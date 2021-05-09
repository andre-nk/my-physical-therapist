part of "provider.dart";

final generalContentServiceProvider = Provider<GeneralContentServices>((ref) => GeneralContentServices(
  ref.watch(firebaseFirestoreProvider),
));

final userScaleProvider = StreamProvider.family<List<dynamic>, String>((ref, uid){
  final reference = ref.watch(generalContentServiceProvider);
  return reference.userScaleGetter(uid);
});


