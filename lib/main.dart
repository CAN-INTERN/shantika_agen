import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shantika_agen/features/chat/cubit/chat_cubit.dart';
import 'package:shantika_agen/features/home/exchange_tickect/cubit/exchange_ticket_cubit.dart';
import 'package:shantika_agen/features/profile/about%20us/cubit/about_us_cubit.dart';
import 'package:shantika_agen/features/profile/faq/cubit/faq_cubit.dart';
import 'package:shantika_agen/features/profile/privacy_policy/cubit/privacy_policy_cubit.dart';
import 'package:shantika_agen/features/profile/terms%20and%20condition/cubit/terms_condition_cubit.dart';
import 'package:shantika_agen/repository/about_us_repository.dart';
import 'package:shantika_agen/repository/chat_repository.dart';
import 'package:shantika_agen/repository/exchange_ticket_repository.dart';
import 'package:shantika_agen/repository/faq_repository.dart';
import 'package:shantika_agen/repository/privacy_policy_repository.dart';
import 'package:shantika_agen/repository/profile_repository.dart';
import 'package:shantika_agen/repository/terms_condition_repository.dart';
import 'package:shantika_agen/splash_screen.dart';
import 'package:shantika_agen/ui/theme.dart';
import 'package:shantika_agen/config/user_preferences.dart';
import 'config/service_locator.dart';
import 'features/profile/personal information/cubit/personal_info_cubit.dart';
import 'firebase_options.dart';
import 'features/authentication/cubit/login_cubit.dart';
import 'features/authentication/login_screen.dart';
import 'features/navigation/navigation_screen.dart';
import 'features/navigation/cubit/update_fcm_token_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setUpLocator(navigatorKey);

  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        ///Authentication
        BlocProvider(create: (context) {final cubit = LoginCubit();cubit.init();return cubit;}),
        BlocProvider(create: (context) => UpdateFcmTokenCubit()),

        ///Home
        BlocProvider(create: (context) => ExchangeTicketCubit(serviceLocator<ExchangeTicketRepository>())),

        /// Chat
        BlocProvider(create: (context) => ChatCubit(serviceLocator<ChatRepository>())),

        /// Profile
        BlocProvider(create: (context) => PersonalInfoCubit(serviceLocator<ProfileRepository>()),),
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', 'ID'),
          Locale('en', 'US'),
        ],

        locale: const Locale('id', 'ID'),

        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => NavigationScreen(),
        },
        home: SplashScreen(),
      ),
    );
  }
}