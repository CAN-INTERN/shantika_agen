import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/features/chat/cubit/chat_cubit.dart';
import 'package:shantika_agen/features/profile/about%20us/cubit/about_us_cubit.dart';
import 'package:shantika_agen/features/profile/faq/cubit/faq_cubit.dart';
import 'package:shantika_agen/features/profile/privacy_policy/cubit/privacy_policy_cubit.dart';
import 'package:shantika_agen/features/profile/terms%20and%20condition/cubit/terms_condition_cubit.dart';
import 'package:shantika_agen/repository/about_us_repository.dart';
import 'package:shantika_agen/repository/chat_repository.dart';
import 'package:shantika_agen/repository/faq_repository.dart';
import 'package:shantika_agen/repository/privacy_policy_repository.dart';
import 'package:shantika_agen/repository/terms_condition_repository.dart';
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
        
        /// Chat
        BlocProvider(create: (context) => ChatCubit(serviceLocator<ChatRepository>())),

        ///Profile
        BlocProvider(create: (context) => AboutUsCubit(serviceLocator<AboutUsRepository>())),
        BlocProvider(create: (context) => FaqCubit(serviceLocator<FaqRepository>())),
        BlocProvider(create: (context) => TermsConditionCubit(serviceLocator<TermsConditionRepository>())),
        BlocProvider(create: (context) => PrivacyPolicyCubit(serviceLocator<PrivacyPolicyRepository>())),

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