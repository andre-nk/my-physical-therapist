part of "provider.dart";

final generalContentServiceProvider = Provider<GeneralContentServices>((ref) => GeneralContentServices(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(firebaseAuthProvider)
));

final generalContentProvider = StreamProvider.family<GeneralContentModel, String>((ref, title){
  final reference = ref.watch(generalContentServiceProvider);

  return reference.generalContentModelGetter(title);
});

final userScaleProvider = StreamProvider.autoDispose<List<dynamic>>((ref){
  final reference = ref.watch(generalContentServiceProvider);
  return reference.userScaleGetter;
});

final userScaleSetterProvider = Provider.family<void, List<dynamic>>((ref, info){
  final reference = ref.watch(generalContentServiceProvider);
  
  reference.userScaleSetter(info[0], info[1]);
});

final userPainDescriptionSetter = Provider.family<void, String>((ref, desc){
  final reference = ref.watch(generalContentServiceProvider);
  reference.userPainDescriptionSetter(desc);
});

