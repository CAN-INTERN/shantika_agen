import 'package:dio/dio.dart';
import 'package:shantika_agen/model/chat_model.dart';

import '../data/api/api_service.dart';

class ChatRepository {
  final ApiService _apiService;

  ChatRepository(this._apiService);

  Future<ChatModel> getChats() async {
    try {
      final response = await _apiService.getChats();

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.response.requestOptions,
          response: response.response,
          type: DioExceptionType.badResponse,
          error: 'Failed to fetch chats',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 500) {
            return Exception('Server error. Please try again later.');
          } else if (statusCode == 404) {
            return Exception('Resource not found.');
          } else if (statusCode == 401) {
            return Exception('Unauthorized. Please login again.');
          }
        }
        return Exception('Failed to load data: ${error.message}');

      case DioExceptionType.cancel:
        return Exception('Request cancelled.');

      case DioExceptionType.connectionError:
        return Exception('No internet connection.');

      default:
        return Exception('Something went wrong. Please try again.');
    }
  }
}