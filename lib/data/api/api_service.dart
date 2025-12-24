import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shantika_agen/model/chat_model.dart';
import '../../config/constant.dart';
import '../../model/about_us_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseApi, parser: Parser.JsonSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// Chat
  @GET("/agen/chats")
  Future<HttpResponse<ChatModel>> getChats();

  /// About Us
  @GET("/about_us")
  Future<HttpResponse<AboutUsModel>> about();
}
