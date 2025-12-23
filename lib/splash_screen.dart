import 'package:flutter/material.dart';
import 'package:shantika_agen/ui/color.dart';
import 'package:shantika_agen/ui/dimension.dart';

import 'config/service_locator.dart';
import 'config/user_preference.dart';
import 'features/authentication/login_screen.dart';
import 'features/navigation/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
          () {
        isLogin()
            ? Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationScreen(),
            ),
                (route) => false)
            : Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
                (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  bool isLogin() {
    final userPreference = serviceLocator.get<UserPreference>();
    return userPreference.getToken() != null;
  }

  Widget _buildMainView() {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius500),
            child: Container(
              width: 150,
              height: 150,
              child: Image.asset(
                'assets/images/ic_logo_shantika_agen.png',
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
