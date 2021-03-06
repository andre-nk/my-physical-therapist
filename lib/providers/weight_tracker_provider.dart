part of "provider.dart";

final weightTrackerServiceProvider = Provider<WeightTrackerServices>((ref) => WeightTrackerServices(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(firebaseAuthProvider)
));

final weightTrackerProvider = StreamProvider.autoDispose<List<WeightValue>>((ref){
  final reference = ref.watch(weightTrackerServiceProvider);

  return reference.weightValuesGetter;
});

final weightRecordAdderProvider = Provider.family<void, List<dynamic>>((ref, weightValue){
  final reference = ref.watch(weightTrackerServiceProvider);
  
  reference.addWeightRecord(weightValue);
});