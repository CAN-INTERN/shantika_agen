import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shantika_agen/model/chat_model.dart';
import 'package:shantika_agen/model/faq_model.dart';
import 'package:shantika_agen/model/privacy_policy_model.dart';
import 'package:shantika_agen/model/terms_condition_model.dart';
import 'package:shantika_agen/model/time_classification_model.dart';
import 'package:shantika_agen/model/user_model.dart';
import '../../config/constant.dart';
import '../../model/about_us_model.dart';
import '../../model/agency_model.dart';
import '../../model/fleet_class_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseApi, parser: Parser.JsonSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// Login Google
  @POST("/agen/login/email")
  Future<HttpResponse<UserModel>> loginWithEmail(
      @Body() Map<String, dynamic> body);

  /// Login Phone
  @POST("/agen/login/phone")
  Future<HttpResponse<UserModel>> loginWithPhone(
      @Body() Map<String, dynamic> body);

  /// Update Profile (Upload Avatar)
  @POST("/agen/update")
  Future<HttpResponse<UserModel>> updateProfile(
    @Part(name: 'avatar') File? avatar,
  );

  /// Get Profile
  @GET("/agen/profile")
  Future<HttpResponse<UserModel>> getProfile();

  /// Chat
  @GET("/agen/chats")
  Future<HttpResponse<ChatModel>> getChats();

  /// About Us
  @GET("/about_us")
  Future<HttpResponse<AboutUsModel>> about();

  /// FAQ
  @GET("/faq")
  Future<HttpResponse<FaqModel>> faq();

  /// Terms and Conditions
  @GET("/term_and_condition")
  Future<HttpResponse<TermsConditionModel>> termConditions();

  /// Privacy Policy
  @GET("/privacy_policy")
  Future<HttpResponse<PrivacyPolicyModel>> privacyPolicy();

  /// Get Agencies
  @GET("/customer/agencies")
  Future<HttpResponse<AgencyModel>> getAgencies();

  /// Get Time
  @GET("/time")
  Future<HttpResponse<TimeClassificationModel>> getTimeClassification();

  @GET("/fleet_classes/available")
  Future<HttpResponse<FleetClassModel>> getAvailableFleetClasses(
    @Query("agency_id") int agencyId,
    @Query("time_classification_id") int timeClassificationId,
    @Query("date") String date,
  );
}
