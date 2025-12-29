import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../config/user_preferences.dart';
import '../data/api/api_service.dart';
import '../model/user_model.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService;

  AuthRepository(this._apiService);

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in dibatalkan');
      }

      // 2. Get Google Auth
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Firebase Sign-In
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase authentication gagal');
      }

      print('✅ Firebase Sign-In Success');
      print('Email: ${firebaseUser.email}');

      // 4. Login ke Backend API
      try {
        final response = await _apiService.loginWithEmail({
          'email': firebaseUser.email!,
        });

        final loginData = response.data;

        // ✅ Check response code first
        if (loginData.code != 200) {
          throw Exception(loginData.message);
        }

        // ✅ Check if user and token exist
        if (loginData.user == null || loginData.token == null) {
          throw Exception('Data login tidak lengkap');
        }

        final user = loginData.user!;
        final token = loginData.token!;

        print('✅ API Login Success');
        print('Token: $token');
        print('User: ${user.name}');

        // 5. Save ke SharedPreferences - ✅ FIXED NULL SAFETY
        await UserPreferences.saveUserData(
          userId: firebaseUser.uid,
          email: user.email,
          name: user.name,
          phone: user.phone,
          token: token,
          uuid: user.uuid,
          photoUrl: (user.avatarUrl?.isNotEmpty ?? false) ? user.avatarUrl : null,
          address: (user.address?.isNotEmpty ?? false) ? user.address : null,
        );

        print('✅ Data saved to SharedPreferences');

        return user;

      } catch (apiError) {
        print('❌ API Error: $apiError');

        final errorString = apiError.toString();

        // Handle specific errors
        if (errorString.contains('404')) {
          throw Exception('USER_NOT_REGISTERED');
        } else if (errorString.contains('401')) {
          throw Exception('UNAUTHORIZED');
        } else if (errorString.contains('terdaftar di akun lain')) {
          throw Exception('PHONE_ALREADY_REGISTERED');
        }

        rethrow;
      }

    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Firebase Error: ${e.code} - ${e.message}');
      throw Exception('FIREBASE_ERROR: ${e.message}');
    } catch (e) {
      print('❌ Error in signInWithGoogle: $e');
      rethrow;
    }
  }

  /// Get current user
  User? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) return null;

    final userName = UserPreferences.userName;
    final userEmail = UserPreferences.userEmail;
    final userUuid = UserPreferences.uuid;

    if (userName == null || userEmail == null) return null;

    // Return User dari stored data
    return User(
      id: 0,
      name: userName,
      phone: UserPreferences.userPhone ?? '',
      email: userEmail,
      avatar: null,
      birth: null,
      birthPlace: null,
      address: UserPreferences.userAddress,
      gender: null,
      uuid: userUuid ?? firebaseUser.uid,
      deletedAt: null,
      createdAt: null,
      updatedAt: null,
      isActive: true,
      avatarUrl: UserPreferences.userPhoto,
      nameAgent: null,
      agencies: null,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await UserPreferences.clearUserData();
      print('✅ Sign out success');
    } catch (e) {
      print('❌ Error signing out: $e');
      rethrow;
    }
  }

  /// Check if logged in
  bool isLoggedIn() {
    return UserPreferences.isLoggedIn && _firebaseAuth.currentUser != null;
  }
}