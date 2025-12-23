import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/user_preference.dart';
import '../features/authentication/login_screen.dart';
import '../ui/color.dart';
import '../ui/dimension.dart';
import '../ui/typography.dart';

class AuthInterceptor extends Interceptor {
  final UserPreference _userPreference;
  final GlobalKey<NavigatorState> navigatorKey;

  AuthInterceptor({
    required UserPreference userPreference,
    required this.navigatorKey,
  }) : _userPreference = userPreference;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _userPreference.getToken();

    debugPrint('Endpoint: ${options.method} ${options.path}');
    debugPrint('Token: ${token != null ? "${token.substring(0, 20)}..." : "NULL"}');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('Token injected');
    } else {
      debugPrint('NO TOKEN AVAILABLE');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[${response.requestOptions.method}] ${response.requestOptions.path} - ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    debugPrint('AuthInterceptor - Status Code: $statusCode');
    debugPrint('Error Type: ${err.type}');
    debugPrint('URL: ${err.requestOptions.path}');
    debugPrint('Response Data: ${err.response?.data}');

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      debugPrint('Network Error - No auto-logout');
      super.onError(err, handler);
      return;
    }

    if (statusCode == 401 ||
        statusCode == 403 ||
        _isMultiDeviceLoginError(err)) {

      final errorMessage = _getErrorMessage(err);
      debugPrint('Authentication Error Detected: $errorMessage');

      try {
        await _userPreference.removeToken();
        await _userPreference.clearData();
        debugPrint('User data cleared');
        final navigator = navigatorKey.currentState;

        if (navigator != null && navigator.overlay?.context != null) {
          final context = navigator.overlay!.context;

          debugPrint('Navigator found, showing dialog...');
          if (context.mounted) {
            _showLogoutDialog(context, errorMessage);
          }
        } else {
          debugPrint('Navigator or context is null!');
          _redirectToLogin(navigator);
        }
      } catch (e, stackTrace) {
        debugPrint('Error during logout: $e');
        debugPrint('Stack: $stackTrace');
      }
    } else {
      debugPrint('Non-auth error: $statusCode');
    }

    super.onError(err, handler);
  }

  void _showLogoutDialog(BuildContext context, String message) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutBack,
            ),
          ),
          child: FadeTransition(
            opacity: anim1,
            child: AlertDialog(
              backgroundColor: black00,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius400),
              ),
              contentPadding: EdgeInsets.all(paddingL),

              icon: Container(
                padding: EdgeInsets.all(padding16),
                decoration: BoxDecoration(
                  color: red100.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_clock_outlined,
                  size: 48,
                  color: red500,
                ),
              ),

              title: Text(
                'Sesi Berakhir',
                textAlign: TextAlign.center,
                style: lgBold,
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: smRegular.copyWith(
                      color: black600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),

              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      final navigator = navigatorKey.currentState;
                      _redirectToLogin(navigator);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(vertical: padding16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius300),
                      ),
                    ),
                    child: Text(
                      'Login Kembali',
                      style: mdSemiBold.copyWith(color: black00),
                    ),
                  ),
                ),
              ],
              actionsPadding: EdgeInsets.fromLTRB(paddingL, 0, paddingL, paddingL),
            ),
          ),
        );
      },
    );
  }

  void _redirectToLogin(NavigatorState? navigator) {
    if (navigator != null) {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (route) => false,
      );
      debugPrint('✅ Redirected to LoginScreen');
    }
  }

  bool _isMultiDeviceLoginError(DioException err) {
    if (err.response?.statusCode != 400) return false;

    final data = err.response?.data;
    if (data == null) return false;

    final message = (data is Map)
        ? (data['message'] ?? data['error'] ?? '').toString().toLowerCase()
        : data.toString().toLowerCase();

    return message.contains('login ulang') ||
        message.contains('regis ulang') ||
        message.contains('harus login') ||
        message.contains('logged in') ||
        message.contains('another device') ||
        message.contains('multiple') ||
        message.contains('device') ||
        (message.contains('session') && message.contains('active'));
  }

  String _getErrorMessage(DioException err) {
    if (err.response?.statusCode == 400 && _isMultiDeviceLoginError(err)) {
      final data = err.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return 'Akun Anda telah login di perangkat lain. Silakan login kembali.';
    } else if (err.response?.statusCode == 401) {
      return 'Sesi Anda telah berakhir. Silakan login kembali.';
    } else if (err.response?.statusCode == 403) {
      return 'Akses ditolak. Silakan login kembali.';
    }
    return 'Sesi Anda telah berakhir. Silakan login kembali.';
  }
}