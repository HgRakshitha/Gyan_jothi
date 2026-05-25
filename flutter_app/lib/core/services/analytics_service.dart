/// Analytics service stub — wire to Firebase Analytics or similar.
abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});
  Future<void> setUserId(String userId);
}

class NoOpAnalyticsService implements AnalyticsService {
  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {}

  @override
  Future<void> setUserId(String userId) async {}
}
