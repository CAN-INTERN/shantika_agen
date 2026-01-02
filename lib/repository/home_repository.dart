import 'package:dio/dio.dart';
import '../data/api/api_service.dart';
import '../model/agency_model.dart';
import '../model/fleet_class_model.dart';
import '../model/time_classification_model.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

  Future<List<Agency>> getAgencies() async {
    try {
      final response = await _apiService.getAgencies();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success ?? false) {
          return data.agencies ?? [];
        } else {
          throw Exception(data.message ?? 'Failed to load agencies');
        }
      } else {
        throw Exception('Failed to load agencies');
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

  Future<List<Time>> getTimeClassification() async {
    try {
      final response = await _apiService.getTimeClassification();

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success ?? false) {
          return data.time ?? [];
        } else {
          throw Exception(data.message ?? 'Failed to load time classification');
        }
      } else {
        throw Exception('Failed to load time classification');
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

  Future<List<FleetClass>> getAvailableFleetClasses({
    required int agencyId,
    required int timeClassificationId,
    required String date,
  }) async {
    try {
      final response = await _apiService.getAvailableFleetClasses(
        agencyId,
        timeClassificationId,
        date,
      );

      if (response.response.statusCode == 200) {
        final data = response.data;
        if (data.success ?? false) {
          return data.fleetClasses ?? [];
        } else {
          throw Exception(data.message ?? 'Failed to load fleet classes');
        }
      } else {
        throw Exception('Failed to load fleet classes');
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
