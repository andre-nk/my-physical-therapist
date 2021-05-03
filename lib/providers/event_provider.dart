part of "provider.dart";

final eventListProvider = StreamProvider.autoDispose<List<EventModel>>((ref){
  final exercisesServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(firebaseAuthProvider)
  )));

  return exercisesServiceProvider.eventModelList;
});