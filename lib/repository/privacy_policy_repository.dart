import 'package:dio/dio.dart';
import '../data/api/api_service.dart';
import '../model/privacy_policy_model.dart';

class PrivacyPolicyRepository {
  final ApiService _apiService;

  PrivacyPolicyRepository(this._apiService);

  Future<PrivacyPolicy> getPrivacyPolicy() async {
    try {
      final response = await _apiService.privacyPolicy();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success) {
          return data.privacyPolicy;
        } else {
          throw Exception(data.message);
        }
      } else {
        throw Exception('Failed to load privacy policy');
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