import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_agen/config/user_preference.dart';
import 'package:shantika_agen/repository/about_us_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api/api_service.dart';
import '../repository/chat_repository.dart';
import '../utility/auth_interceptor.dart';
import 'constant.dart';
import 'env/env.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpLocator(GlobalKey<NavigatorState> navigatorKey) async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<UserPreference>(UserPreference(prefs));

  serviceLocator.registerLazySingleton<Dio>(() {
    final dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: timeOutDuration),
      receiveTimeout: const Duration(seconds: timeOutDuration),
      persistentConnection: false,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "x-api-key": Env.apiKey,
      },
    );

    dio.interceptors.add(
      AuthInterceptor(
        userPreference: serviceLocator.get<UserPreference>(),
        navigatorKey: navigatorKey,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(AwesomeDioInterceptor());
    }

    return dio;
  });

  serviceLocator.registerLazySingleton<ApiService>(
        () => ApiService(
      serviceLocator.get<Dio>(),
      baseUrl: baseApi,
    ),
  );
  //
  // serviceLocator.registerLazySingleton<AppSettingsRepository>(
  //       () => AppSettingsRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<NotificationRepository>(
  //       () => NotificationRepository(serviceLocator<ApiService>()),
  // );
  //
  serviceLocator.registerLazySingleton<ChatRepository>(
        () => ChatRepository(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<AboutUsRepository>(
        () => AboutUsRepository(serviceLocator<ApiService>()),
  );
  //
  // serviceLocator.registerLazySingleton<HomeRepository>(
  //       () => HomeRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<TicketRepository>(
  //       () => TicketRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<InfoAgencyRepository>(
  //       () => InfoAgencyRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<SocialMediaRepository>(
  //       () => SocialMediaRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<OrderRepository>(
  //       () => OrderRepository(serviceLocator<ApiService>()),
  // );
  //
  // serviceLocator.registerLazySingleton<MembershipRepository>(
  //       () => MembershipRepository(serviceLocator<ApiService>()),
  // );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  serviceLocator.registerSingleton<PackageInfo>(packageInfo);
}