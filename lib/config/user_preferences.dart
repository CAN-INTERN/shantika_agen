import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  // Keys
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  static const String _keyUserPhoto = 'user_photo';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserAddress = 'user_address';
  static const String _keyUserGender = 'user_gender';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUuid = 'uuid';
  static const String _keyFcmToken = 'fcm_token';

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save complete user data
  static Future<bool> saveUserData({
    required String userId,
    required String email,
    String? name,
    String? photoUrl,
    String? phone,
    String? address,
    String? gender,
    String? token,
    String? uuid,
  }) async {
    try {
      await _preferences?.setString(_keyUserId, userId);
      await _preferences?.setString(_keyUserEmail, email);

      if (name != null) await _preferences?.setString(_keyUserName, name);
      if (photoUrl != null) await _preferences?.setString(_keyUserPhoto, photoUrl);
      if (phone != null) await _preferences?.setString(_keyUserPhone, phone);
      if (address != null) await _preferences?.setString(_keyUserAddress, address);
      if (gender != null) await _preferences?.setString(_keyUserGender, gender);
      if (token != null) await _preferences?.setString(_keyAuthToken, token);
      if (uuid != null) await _preferences?.setString(_keyUuid, uuid);

      await _preferences?.setBool(_keyIsLoggedIn, true);

      if (token != null) {
        final displayToken = token.length > 20 ? token.substring(0, 20) : token;
        print('- Token: $displayToken...');
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get user ID
  static String? get userId => _preferences?.getString(_keyUserId);

  /// Get user email
  static String? get userEmail => _preferences?.getString(_keyUserEmail);

  /// Get user name
  static String? get userName => _preferences?.getString(_keyUserName);

  /// Get user photo URL
  static String? get userPhoto => _preferences?.getString(_keyUserPhoto);

  /// Get user phone
  static String? get userPhone => _preferences?.getString(_keyUserPhone);

  /// Get user address
  static String? get userAddress => _preferences?.getString(_keyUserAddress);

  /// Get user gender
  static String? get userGender => _preferences?.getString(_keyUserGender);

  /// Get auth token
  static String? get authToken => _preferences?.getString(_keyAuthToken);

  /// Get UUID
  static String? get uuid => _preferences?.getString(_keyUuid);

  /// Get FCM token
  static String? get fcmToken => _preferences?.getString(_keyFcmToken);

  /// Check if user is logged in
  static bool get isLoggedIn {
    final loggedIn = _preferences?.getBool(_keyIsLoggedIn) ?? false;
    final hasToken = authToken != null && authToken!.isNotEmpty;
    return loggedIn && hasToken;
  }

  /// Save auth token
  static Future<bool> saveAuthToken(String token) async {
    try {
      await _preferences?.setString(_keyAuthToken, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Save FCM token
  static Future<bool> saveFcmToken(String token) async {
    try {
      await _preferences?.setString(_keyFcmToken, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Clear all user data (logout)
  static Future<bool> clearUserData() async {
    try {
      await _preferences?.remove(_keyUserId);
      await _preferences?.remove(_keyUserEmail);
      await _preferences?.remove(_keyUserName);
      await _preferences?.remove(_keyUserPhoto);
      await _preferences?.remove(_keyUserPhone);
      await _preferences?.remove(_keyUserAddress);
      await _preferences?.remove(_keyUserGender);
      await _preferences?.remove(_keyAuthToken);
      await _preferences?.remove(_keyUuid);
      await _preferences?.setBool(_keyIsLoggedIn, false);

      print('✅ User data cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing user data: $e');
      return false;
    }
  }

  /// Clear ALL data including FCM token
  static Future<bool> clearAll() async {
    try {
      await _preferences?.clear();
      print('✅ All preferences cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing all data: $e');
      return false;
    }
  }

  /// Debug: Print all stored values
  static void printAll() {
    print('=== UserPreferences Debug ===');
    print('User ID: $userId');
    print('Email: $userEmail');
    print('Name: $userName');
    print('Phone: $userPhone');
    print('Photo: $userPhoto');
    print('Address: $userAddress');
    print('Gender: $userGender');
    print('UUID: $uuid');

    if (authToken != null) {
      final displayToken = authToken!.length > 20 ? authToken!.substring(0, 20) : authToken;
      print('Token: $displayToken...');
    } else {
      print('Token: null');
    }

    if (fcmToken != null) {
      final displayFcm = fcmToken!.length > 20 ? fcmToken!.substring(0, 20) : fcmToken;
      print('FCM Token: $displayFcm...');
    } else {
      print('FCM Token: null');
    }

    print('Is Logged In: $isLoggedIn');
    print('============================');
  }
}