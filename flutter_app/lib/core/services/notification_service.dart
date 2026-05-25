/// Notification service stub — wire to Firebase Messaging.
abstract class NotificationService {
  Future<void> initialize();
  Future<void> requestPermission();
  Future<String?> getToken();
}

class NoOpNotificationService implements NotificationService {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> requestPermission() async {}

  @override
  Future<String?> getToken() async => null;
}
