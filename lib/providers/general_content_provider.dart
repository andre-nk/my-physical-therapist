part of "provider.dart";

final generalContentProvider = StreamProvider.family<GeneralContentModel, String>((ref, title){
  final reference = ref.watch(Provider<GeneralContentServices>((ref) => GeneralContentServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return reference.generalContentModelGetter(title);
});

final userScaleProvider = StreamProvider.autoDispose<List<double>>((ref){
  final reference = ref.watch(Provider<GeneralContentServices>((ref) => GeneralContentServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  return reference.userScaleGetter;
});

final userScaleSetterProvider = Provider.family<void, List<dynamic>>((ref, info){
  final reference = ref.watch(Provider<GeneralContentServices>((ref) => GeneralContentServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  
  reference.userScaleSetter(info[0], info[1]);
});