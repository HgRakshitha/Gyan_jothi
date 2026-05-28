import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared_prefs_provider.dart';

class UserModel {
  final String name;
  final String className;
  final int coins;
  final Set<String> completedActivities;
  final String avatarPath;
  final int age;
  final int stars;
  final int streakDays;
  final DateTime? lastActiveDate;

  const UserModel({
    required this.name,
    required this.className,
    required this.coins,
    this.completedActivities = const {},
    this.avatarPath = '',
    this.age = 0,
    this.stars = 0,
    this.streakDays = 0,
    this.lastActiveDate,
  });

  UserModel copyWith({
    String? name,
    String? className,
    int? coins,
    Set<String>? completedActivities,
    String? avatarPath,
    int? age,
    int? stars,
    int? streakDays,
    DateTime? lastActiveDate,
  }) {
    return UserModel(
      name: name ?? this.name,
      className: className ?? this.className,
      coins: coins ?? this.coins,
      completedActivities: completedActivities ?? this.completedActivities,
      avatarPath: avatarPath ?? this.avatarPath,
      age: age ?? this.age,
      stars: stars ?? this.stars,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'className': className,
      'coins': coins,
      'completedActivities': completedActivities.toList(),
      'avatarPath': avatarPath,
      'age': age,
      'stars': stars,
      'streakDays': streakDays,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String? ?? 'Student',
      className: map['className'] as String? ?? 'Not Selected',
      coins: map['coins'] as int? ?? 0,
      completedActivities: (map['completedActivities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          const {},
      avatarPath: map['avatarPath'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      stars: map['stars'] as int? ?? 0,
      streakDays: map['streakDays'] as int? ?? 0,
      lastActiveDate: map['lastActiveDate'] != null ? DateTime.tryParse(map['lastActiveDate']) : null,
    );
  }
}

class UserNotifier extends StateNotifier<UserModel> {
  final Ref ref;
  static const _userKey = 'user_data';

  UserNotifier(this.ref) : super(const UserModel(
    name: 'Student', 
    className: 'Not Selected', 
    coins: 0,
  )) {
    _loadUser();
  }

  void _loadUser() {
    final prefs = ref.read(sharedPreferencesProvider);
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        final decoded = jsonDecode(userJson) as Map<String, dynamic>;
        state = UserModel.fromJson(decoded);
      } catch (e) {
        // Fallback to default state if parsing fails
      }
    }
  }

  void _saveUser(UserModel user) {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  void setUser(UserModel user) {
    state = user;
    _saveUser(user);
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
    _saveUser(state);
  }

  void updateAvatar(String newAvatarPath) {
    state = state.copyWith(avatarPath: newAvatarPath);
    _saveUser(state);
  }

  void updateClassAndAge(int newAge, String newClassName) {
    state = state.copyWith(age: newAge, className: newClassName);
    _saveUser(state);
  }

  void addCoins(int amount) {
    state = state.copyWith(coins: state.coins + amount);
    _saveUser(state);
  }

  bool completeActivity(String activityId, int coinReward) {
    if (state.completedActivities.contains(activityId)) {
      return false;
    }
    
    // Calculate streak
    final now = DateTime.now();
    int newStreak = state.streakDays;
    DateTime? newLastActive = state.lastActiveDate;
    
    if (newLastActive == null) {
      newStreak = 1;
      newLastActive = now;
    } else {
      final lastDate = DateTime(newLastActive.year, newLastActive.month, newLastActive.day);
      final today = DateTime(now.year, now.month, now.day);
      final diff = today.difference(lastDate).inDays;
      if (diff == 1) {
        newStreak++;
        newLastActive = now;
      } else if (diff > 1) {
        newStreak = 1;
        newLastActive = now;
      } else {
        newLastActive = now;
      }
    }

    state = state.copyWith(
      coins: state.coins + coinReward,
      completedActivities: {...state.completedActivities, activityId},
      streakDays: newStreak,
      lastActiveDate: newLastActive,
    );
    _saveUser(state);
    return true;
  }
  
  void earnStars(int amount) {
    state = state.copyWith(stars: state.stars + amount);
    _saveUser(state);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(ref),
);
