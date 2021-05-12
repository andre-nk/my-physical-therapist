part of "provider.dart";

final exercisesServiceProvider = Provider<ExercisesService>((ref) => ExercisesService(
  ref.watch(firebaseFirestoreProvider),
));

final exercisesProvider = StreamProvider.family<List<ExerciseModel>, String>((ref, uid){
  return ref.watch(exercisesServiceProvider).exerciseListGetter(uid);
});