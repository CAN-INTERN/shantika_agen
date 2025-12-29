import 'package:dio/dio.dart';
import '../data/api/api_service.dart';
import '../model/faq_model.dart';

class FaqRepository {
  final ApiService _apiService;

  FaqRepository(this._apiService);

  Future<List<Faq>> getFaqs() async {
    try {
      final response = await _apiService.faq();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success) {
          return data.faqs;
        } else {
          throw Exception(data.message);
        }
      } else {
        throw Exception('Failed to load FAQs');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Server error');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}