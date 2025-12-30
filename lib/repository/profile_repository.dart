import 'dart:io';
import 'package:shantika_agen/data/api/api_service.dart';
import 'package:shantika_agen/model/user_model.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<UserModel> updateProfile(File avatar) async {
    try {
      final response = await _apiService.updateProfile(avatar);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data.message ?? 'Update failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _apiService.getProfile();

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data.message ?? 'Failed to load profile');
      }
    } catch (e) {
      rethrow;
    }
  }
}