part of "provider.dart";

final weightTrackerProvider = StreamProvider.autoDispose<List<WeightValue>>((ref){
  final reference = ref.watch(Provider<WeightTrackerServices>((ref) => WeightTrackerServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return reference.weightValuesGetter;
});

final weightRecordAdderProvider = Provider.family<void, List<dynamic>>((ref, weightValue){
  final reference = ref.watch(Provider<WeightTrackerServices>((ref) => WeightTrackerServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));
  
  reference.addWeightRecord(weightValue);
});