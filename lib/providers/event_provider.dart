part of "provider.dart";

final eventListProvider = StreamProvider.autoDispose<List<EventModel>>((ref){
  final eventServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return eventServiceProvider.eventModelList;
});

final eventAdderProvider = FutureProvider.family<void, EventModel>((ref, eventModel){
  final eventServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return eventServiceProvider.addEvent(eventModel);
});

final eventUpdaterProvider = FutureProvider.family<void, EventModel>((ref, eventModel){
  final eventServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return eventServiceProvider.editEvent(eventModel);
});

final eventDeleterProvider = FutureProvider.family<void, String>((ref, uid){
  final eventServiceProvider = ref.watch(Provider<EventServices>((ref) => EventServices(
    ref.watch(firebaseFirestoreProvider),
  )));

  return eventServiceProvider.deleteEvent(uid);
});