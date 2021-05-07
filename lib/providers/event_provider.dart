part of "provider.dart";

final eventListProvider = StreamProvider.autoDispose<List<EventModel>>((ref){
  final exercisesServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return exercisesServiceProvider.eventModelList;
});

final eventAdderProvider = FutureProvider.family<void, EventModel>((ref, eventModel){
  final exercisesServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return exercisesServiceProvider.addEvent(eventModel);
});