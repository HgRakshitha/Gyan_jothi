import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String name;
  final String className;
  final int coins;
  final Set<String> completedActivities;
  final String avatarPath;
  final int age;

  const UserModel({
    required this.name,
    required this.className,
    required this.coins,
    this.completedActivities = const {},
    this.avatarPath = '',
    this.age = 0,
  });

  UserModel copyWith({
    String? name,
    String? className,
    int? coins,
    Set<String>? completedActivities,
    String? avatarPath,
    int? age,
  }) {
    return UserModel(
      name: name ?? this.name,
      className: className ?? this.className,
      coins: coins ?? this.coins,
      completedActivities: completedActivities ?? this.completedActivities,
      avatarPath: avatarPath ?? this.avatarPath,
      age: age ?? this.age,
    );
  }
}

class UserNotifier extends StateNotifier<UserModel> {
  // Start with default empty user and 0 coins
  UserNotifier() : super(const UserModel(
    name: 'Student', 
    className: 'Not Selected', 
    coins: 0,
  ));

  void setUser(UserModel user) => state = user;

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updateAvatar(String newAvatarPath) {
    state = state.copyWith(avatarPath: newAvatarPath);
  }

  void updateClassAndAge(int newAge, String newClassName) {
    state = state.copyWith(age: newAge, className: newClassName);
  }

  void addCoins(int amount) {
    state = state.copyWith(coins: state.coins + amount);
  }

  bool completeActivity(String activityId, int coinReward) {
    if (state.completedActivities.contains(activityId)) {
      return false;
    }
    state = state.copyWith(
      coins: state.coins + coinReward,
      completedActivities: {...state.completedActivities, activityId},
    );
    return true;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);
