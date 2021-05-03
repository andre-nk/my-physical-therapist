part of "provider.dart";

final exercisesProvider = StreamProvider.autoDispose<List<ExerciseModel>>((ref){
  final exercisesServiceProvider = ref.watch(Provider<ExercisesService>((ref) => ExercisesService(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return exercisesServiceProvider.exerciseListGetter;
});

final setExerciseCompleteProvider = Provider.family<void, String>((ref, id) => ExercisesService(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(firebaseAuthProvider)
).completeExercise(id));