import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  final SharedPreferences prefs;

  static const String _keyToken = "token";
  static const String _keyUser = "user";

  UserPreference(this.prefs);

  Future<void> setToken(String newToken) async {
    debugPrint('UserPreference.setToken() called');
    debugPrint('Token to save: ${newToken.substring(0, 50)}...');
    debugPrint('Token length: ${newToken.length}');

    final success = await prefs.setString(_keyToken, newToken);
    debugPrint('setString result: $success');
    final saved = prefs.getString(_keyToken);

    if (saved != newToken) {
      debugPrint('Saved token: ${saved?.substring(0, 50)}...');
      debugPrint('Expected:    ${newToken.substring(0, 50)}...');
    }
  }

  Future<void> removeToken() async {
    debugPrint('Removing token');
    await prefs.remove(_keyToken);
  }

  String? getToken() {
    return prefs.getString(_keyToken);
  }

  // Future<bool> setUser(UsersModel data) async {
  //   try {
  //     debugPrint('Saving user data:');
  //     debugPrint('Name: "${data.name}"');
  //     debugPrint('Phone: "${data.phone}"');
  //     debugPrint('Email: "${data.email}"');
  //
  //     final userJson = json.encode(data.toJson());
  //     debugPrint('JSON: $userJson');
  //
  //     final success = await prefs.setString(_keyUser, userJson);
  //
  //     if (!success) {
  //       debugPrint('SharedPreferences.setString returned false');
  //       return false;
  //     }
  //     await prefs.reload();
  //     final savedData = prefs.getString(_keyUser);
  //     if (savedData == null || savedData.isEmpty) {
  //       debugPrint('Data not found after save');
  //       return false;
  //     }
  //
  //     final verifiedUser = UsersModel.fromJson(json.decode(savedData));
  //     debugPrint('User saved and verified:');
  //     debugPrint('Name: "${verifiedUser.name}"');
  //     debugPrint('Phone: "${verifiedUser.phone}"');
  //     debugPrint('Email: "${verifiedUser.email}"');
  //
  //     return true;
  //
  //   } catch (e, stackTrace) {
  //     debugPrint('ERROR in setUser(): $e');
  //     debugPrint('Stack: $stackTrace');
  //     return false;
  //   }
  // }
  //
  // UsersModel getUser() {
  //   try {
  //     final userString = prefs.getString(_keyUser);
  //
  //     if (userString == null || userString.isEmpty) {
  //       debugPrint('No user data found');
  //       return UsersModel();
  //     }
  //
  //     final userMap = json.decode(userString) as Map<String, dynamic>;
  //     final user = UsersModel.fromJson(userMap);
  //
  //     debugPrint('User loaded:');
  //     debugPrint('Name: "${user.name}"');
  //     debugPrint('Phone: "${user.phone}"');
  //     debugPrint('Email: "${user.email}"');
  //
  //     return user;
  //
  //   } catch (e) {
  //     debugPrint('ERROR in getUser(): $e');
  //     return UsersModel();
  //   }
  // }

  // String get userName {
  //   final user = getUser();
  //   return user.name ?? '';
  // }
  //
  // String get userEmail {
  //   final user = getUser();
  //   return user.email ?? '';
  // }
  //
  // String get userPhone {
  //   final user = getUser();
  //   return user.phone ?? '';
  // }
  //
  // bool get isLoggedIn {
  //   final token = getToken();
  //   return token != null && token.isNotEmpty;
  // }
  //
  // bool get hasCompleteBookingData {
  //   final user = getUser();
  //   final hasData = user.name?.isNotEmpty == true &&
  //       user.email?.isNotEmpty == true &&
  //       user.phone?.isNotEmpty == true;
  //
  //   debugPrint('Complete data check: $hasData');
  //   if (!hasData) {
  //     debugPrint('Name: "${user.name}" (${user.name?.isNotEmpty})');
  //     debugPrint('Email: "${user.email}" (${user.email?.isNotEmpty})');
  //     debugPrint('Phone: "${user.phone}" (${user.phone?.isNotEmpty})');
  //   }
  //
  //   return hasData;
  // }
  //
  // Map<String, String> getUserDataForBooking() {
  //   final user = getUser();
  //   return {
  //     'name': user.name ?? '',
  //     'email': user.email ?? '',
  //     'phone': user.phone ?? '',
  //   };
  // }

  Future<void> clearData() async {
    debugPrint('Clearing all user data');
    await prefs.clear();
  }

  Future<void> clearUserOnly() async {
    debugPrint('Clearing user data only');
    await prefs.remove(_keyUser);
  }

  // void printAllData() {
  //   debugPrint('Current UserPreference Data:');
  //   debugPrint('Token: ${getToken() != null ? "YEP" : "NOY"}');
  //   debugPrint('User: ${prefs.getString(_keyUser) != null ? "YEP" : "NOY"}');
  //   debugPrint('IsLoggedIn: $isLoggedIn');
  //   debugPrint('HasCompleteData: $hasCompleteBookingData');
  // }

}