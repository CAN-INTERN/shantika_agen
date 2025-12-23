import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/splash_screen.dart';
import 'package:shantika_agen/ui/theme.dart';
import 'config/service_locator.dart';
import 'features/authentication/cubit/login_cubit.dart';
import 'features/authentication/login_screen.dart';
import 'features/navigation/navigation_screen.dart';
import 'features/navigation/cubit/update_fcm_token_cubit.dart'; // Add this import

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator(navigatorKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => UpdateFcmTokenCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shantika Agen',
        navigatorKey: navigatorKey,
        theme: AppTheme.light,
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => NavigationScreen(),
        },
        home: SplashScreen(),
      ),
    );
  }
}