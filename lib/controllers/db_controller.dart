import '../models/event.dart';
import '../models/user.dart';
import '../models/subscription.dart';
import '../util/fake_db_storage.dart';

class DbController {
  // Singleton
  static DbController _controller = DbController();
  static DbController get instance => _controller;

  FakeDbStorage dbStorage;

  // Methods
  Event getEventById(int eventId) {
    return dbStorage.events[eventId];
  }

  User getUserById(int userId) {
    return dbStorage.users[userId];
  }

  User getAuthorForEvent(int eventId) {
    int userId = dbStorage.events[eventId].authorId;
    return dbStorage.users[userId];
  }

  List<Event> getAllEvents() {
    return dbStorage.events;
  }

  List<Event> getEventsForUser(int userId) {
    return dbStorage.events.where((e) => e.authorId == userId).toList();
  }

  List<Event> getSubscribedEvents(int userId) {
    var subscribtions = dbStorage.subscribtions.where((s) => s.userId == userId).toList();
    var events = [];

    for (var i = 0; i < subscribtions.length; ++i) {
      events.add(dbStorage.events[subscribtions[i].eventId]);
    }

    return events;
  }

  List<User> getSubscribersForEvent(int eventId) {
    var subscribtions = dbStorage.subscribtions.where((s) => s.eventId == eventId).toList();
    var subscribers = [];

    for (var i = 0; i < subscribtions.length; ++i) {
      subscribers.add(dbStorage.users[subscribtions[i].userId]);
    }

    return subscribers;
  }

  void createEvent(Event event) {
    var newId = dbStorage.events.length;
    event.id = newId;

    dbStorage.events.add(event);
  }

  void subscribe(int userId, int eventId) {
    dbStorage.subscribtions.add(Subscribtion(
      eventId,
      userId
    ));
  }

  void unsubscribe(int userId, int eventId) {
    // TODO
  }
}