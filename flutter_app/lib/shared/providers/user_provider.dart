import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String name;
  final String className;
  final int coins;
  final Set<String> completedActivities;

  const UserModel({
    required this.name,
    required this.className,
    required this.coins,
    this.completedActivities = const {},
  });
}

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) => state = user;

  void clearUser() => state = null;

  void addCoins(int amount) {
    if (state != null) {
      state = UserModel(
        name: state!.name,
        className: state!.className,
        coins: state!.coins + amount,
        completedActivities: state!.completedActivities,
      );
    }
  }

  bool completeActivity(String activityId, int coinReward) {
    if (state != null) {
      if (state!.completedActivities.contains(activityId)) {
        return false;
      }
      state = UserModel(
        name: state!.name,
        className: state!.className,
        coins: state!.coins + coinReward,
        completedActivities: {...state!.completedActivities, activityId},
      );
      return true;
    }
    return false;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
  (ref) => UserNotifier()
    ..setUser(const UserModel(
      name: 'Aarav Kumar',
      className: 'Class Playgroup',
      coins: 2206,
      completedActivities: {},
    )),
);
