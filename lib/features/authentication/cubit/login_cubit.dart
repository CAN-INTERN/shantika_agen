import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../config/service_locator.dart';
import '../../../config/user_preference.dart';
import '../../../config/user_preferences.dart';
import '../../../data/api/api_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  late UserPreference _userPreference;
  late ApiService _apiService;

  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void init() {
    _userPreference = serviceLocator.get();
    _apiService = serviceLocator.get();
    print('✅ LoginCubit initialized');
  }

  /// ========================================
  /// 📱 PHONE LOGIN - DIRECT (NO OTP)
  /// ========================================

  /// Login with Phone Number (Direct)
  Future<void> loginWithPhone(String phoneNumber) async {
    print('📱 Login with phone: $phoneNumber');
    emit(LoginStateLoading());

    try {
      final response = await _apiService.loginWithPhone({
        'phone': phoneNumber,
      });

      print('📦 Response status: ${response.response.statusCode}');

      if (response.response.statusCode != 200) {
        throw Exception('Login gagal');
      }

      final loginData = response.data;

      // Check backend's code field
      if (loginData.code != 200) {
        print('❌ Backend error code: ${loginData.code}');
        throw Exception(loginData.message);
      }

      // Check if user and token exist
      if (loginData.user == null || loginData.token == null) {
        throw Exception('Login gagal: Data user tidak lengkap');
      }

      final user = loginData.user!;
      final token = loginData.token!;

      print('✅ Phone login success');
      final displayToken = token.length > 20 ? token.substring(0, 20) : token;
      print('🎫 Token: $displayToken...');
      print('👤 User: ${user.name}');
      print('📱 Phone: ${user.phone}');

      // Save ke UserPreference (OLD)
      await _userPreference.setToken(token);
      print('✅ Saved to OLD UserPreference');

      // Save ke UserPreferences (NEW)
      await UserPreferences.saveUserData(
        userId: user.id.toString(),
        email: user.email,
        name: user.name,
        phone: user.phone,
        token: token,
        uuid: user.uuid,
        photoUrl: (user.avatarUrl?.isNotEmpty ?? false) ? user.avatarUrl : null,
        address: (user.address?.isNotEmpty ?? false) ? user.address : null,
      );
      print('✅ Saved to NEW UserPreferences');

      // Debug print
      UserPreferences.printAll();

      emit(LoginStateSuccess(token: token));

    } catch (e, stackTrace) {
      print('❌ Phone login error: $e');
      print('StackTrace: $stackTrace');

      String errorMessage;
      final errorString = e.toString();

      if (errorString.contains('tidak terdaftar')) {
        errorMessage = 'Nomor HP tidak terdaftar sebagai agen.';
      } else if (errorString.toLowerCase().contains('socket') ||
          errorString.toLowerCase().contains('network')) {
        errorMessage = 'Tidak ada koneksi internet.';
      } else if (errorString.toLowerCase().contains('timeout')) {
        errorMessage = 'Koneksi timeout. Coba lagi.';
      } else {
        errorMessage = errorString.replaceAll('Exception: ', '');
      }

      emit(LoginStateError(message: errorMessage));
    }
  }

  /// ========================================
  /// 🔐 GOOGLE LOGIN (EXISTING)
  /// ========================================

  /// Login dengan Google
  Future<void> loginWithGoogle() async {
    print('🔍 Starting Google login...');
    emit(LoginStateLoading());

    try {
      // ✅ FORCE ACCOUNT PICKER: Sign out dulu untuk clear cache
      print('🔄 Clearing Google Sign-In cache...');
      await _googleSignIn.signOut();

      // Step 1: Google Sign-In (sekarang akan muncul account picker)
      print('📱 Opening Google Sign-In...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('⚠️ User cancelled Google Sign-In');
        emit(LoginInitial());
        return;
      }

      print('✅ Google account selected: ${googleUser.email}');

      // Step 2: Get Google Authentication
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('🔑 Got Google auth credentials');

      // Step 3: Sign in to Firebase
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase authentication failed');
      }

      print('✅ Firebase sign-in success');
      print('📧 Email: ${firebaseUser.email}');
      print('👤 Name: ${firebaseUser.displayName}');

      // Step 4: Login ke Backend API
      print('🌐 Calling backend API: POST /agen/login/email');
      final response = await _apiService.loginWithEmail({
        'email': firebaseUser.email!,
      });

      print('📦 Response status: ${response.response.statusCode}');

      final loginData = response.data;

      // Check HTTP status code
      if (response.response.statusCode != 200) {
        throw Exception(loginData.message);
      }

      // Check backend's code field
      if (loginData.code != 200) {
        print('❌ Backend error code: ${loginData.code}');
        throw Exception(loginData.message);
      }

      // Check if user and token exist
      if (loginData.user == null || loginData.token == null) {
        throw Exception('Login gagal: Data user tidak lengkap');
      }

      print('✅ Backend API login success');
      final displayToken = loginData.token!.length > 20
          ? loginData.token!.substring(0, 20)
          : loginData.token;
      print('🎫 Token: $displayToken...');
      print('👤 User: ${loginData.user!.name}');
      print('📧 Email: ${loginData.user!.email}');

      // Save ke UserPreference (OLD)
      await _userPreference.setToken(loginData.token!);
      print('✅ Saved to OLD UserPreference');

      // Save ke UserPreferences (NEW)
      await UserPreferences.saveUserData(
        userId: firebaseUser.uid,
        email: loginData.user!.email,
        name: loginData.user!.name,
        phone: loginData.user!.phone,
        token: loginData.token!,
        uuid: loginData.user!.uuid,
        photoUrl: (loginData.user!.avatarUrl?.isNotEmpty ?? false) ? loginData.user!.avatarUrl : null,
        address: (loginData.user!.address?.isNotEmpty ?? false) ? loginData.user!.address : null,
      );
      print('✅ Saved to NEW UserPreferences');

      // Debug print
      UserPreferences.printAll();

      emit(LoginStateSuccess(token: loginData.token!));

    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Firebase error: ${e.code} - ${e.message}');

      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Akun sudah terdaftar dengan metode login lain';
          break;
        case 'invalid-credential':
          errorMessage = 'Kredensial tidak valid';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google Sign-In belum diaktifkan';
          break;
        case 'user-disabled':
          errorMessage = 'Akun telah dinonaktifkan';
          break;
        default:
          errorMessage = 'Firebase error: ${e.message}';
      }

      emit(LoginStateError(message: errorMessage));

    } catch (e, stackTrace) {
      print('❌ Login error: $e');
      print('StackTrace: $stackTrace');

      String errorMessage;
      final errorString = e.toString();

      if (errorString.contains('terdaftar di akun lain')) {
        errorMessage = 'Nomor telepon sudah terdaftar di akun lain. Gunakan email yang berbeda.';
      } else if (errorString.contains('belum terdaftar')) {
        errorMessage = 'Akun belum terdaftar. Silakan daftar terlebih dahulu.';
      } else if (errorString.contains('tidak terdaftar sebagai agen')) {
        errorMessage = 'Email tidak terdaftar sebagai agen.';
      } else if (errorString.toLowerCase().contains('socket') ||
          errorString.toLowerCase().contains('network')) {
        errorMessage = 'Tidak ada koneksi internet.';
      } else if (errorString.toLowerCase().contains('timeout')) {
        errorMessage = 'Koneksi timeout. Coba lagi.';
      } else {
        errorMessage = errorString.replaceAll('Exception: ', '');
      }

      emit(LoginStateError(message: errorMessage));
    }
  }

  /// ========================================
  /// 🚪 LOGOUT
  /// ========================================

  Future<void> logout() async {
    try {
      print('🚪 Logging out...');

      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await _userPreference.clearData();
      await UserPreferences.clearUserData();

      print('✅ Logout success');
      emit(LoginInitial());

    } catch (e) {
      print('❌ Logout error: $e');
      emit(LoginStateError(message: 'Logout gagal: ${e.toString()}'));
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    final hasTokenOld = _userPreference.getToken() != null;
    final hasTokenNew = UserPreferences.isLoggedIn;

    return hasTokenOld || hasTokenNew;
  }
}