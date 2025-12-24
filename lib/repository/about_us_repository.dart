import 'package:dio/dio.dart';
import '../data/api/api_service.dart';
import '../model/about_us_model.dart';

class AboutUsRepository {
  final ApiService _apiService;

  AboutUsRepository(this._apiService);

  Future<About> getAboutUs() async {
    try {
      final response = await _apiService.about();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success) {
          return data.about;
        } else {
          throw Exception(data.message);
        }
      } else {
        throw Exception('Failed to load about us');
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