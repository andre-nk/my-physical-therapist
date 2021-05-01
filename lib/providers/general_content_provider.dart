part of "provider.dart";

final generalContentProvider = StreamProvider.family<GeneralContentModel, String>((ref, title){
  final reference = ref.watch(Provider<GeneralContentServices>((ref) => GeneralContentServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return reference.generalContentModelGetter(title);
});