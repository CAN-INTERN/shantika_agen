import 'package:dio/dio.dart';
import '../data/api/api_service.dart';
import '../model/terms_condition_model.dart';

class TermsConditionRepository {
  final ApiService _apiService;

  TermsConditionRepository(this._apiService);

  Future<TermAndCondition> getTermsCondition() async {
    try {
      final response = await _apiService.termConditions();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success) {
          return data.termAndCondition;
        } else {
          throw Exception(data.message);
        }
      } else {
        throw Exception('Failed to load terms and conditions');
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