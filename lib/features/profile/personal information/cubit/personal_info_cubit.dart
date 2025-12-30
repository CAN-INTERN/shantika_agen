import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_agen/model/user_model.dart';
import 'package:shantika_agen/repository/profile_repository.dart';
import 'package:shantika_agen/config/user_preferences.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  final ProfileRepository _repository;

  PersonalInfoCubit(this._repository) : super(PersonalInfoInitial());

  Future<void> getProfile() async {
    try {
      final userModel = await _repository.getProfile();

      if (userModel.code == 200 && userModel.user != null) {
        final user = userModel.user!;

        await UserPreferences.saveUserData(
          userId: UserPreferences.userId ?? user.id.toString(),
          email: user.email,
          name: user.name,
          phone: user.phone,
          token: UserPreferences.authToken ?? '',
          uuid: user.uuid,
          photoUrl: user.avatarUrl?.isNotEmpty == true ? user.avatarUrl : null,
          address: user.address?.isNotEmpty == true ? user.address : null,
          gender: user.gender?.isNotEmpty == true ? user.gender : null,
        );

        emit(ProfileRefreshed(userModel));
      } else {
        emit(PersonalInfoError(userModel.message ?? 'Failed to load profile'));
      }
    } catch (e) {
      print('❌ Get profile error: $e');

      String errorMessage = 'Gagal memuat profil';

      if (e.toString().contains('network') || e.toString().contains('socket')) {
        errorMessage = 'Tidak ada koneksi internet';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Koneksi timeout';
      }

      emit(PersonalInfoError(errorMessage));
    }
  }

  Future<void> updateAvatar(File avatar) async {
    emit(PersonalInfoLoading());

    try {
      final userModel = await _repository.updateProfile(avatar);

      if (userModel.code == 200 && userModel.user != null) {
        final user = userModel.user!;

        await UserPreferences.saveUserData(
          userId: UserPreferences.userId ?? user.id.toString(),
          email: user.email,
          name: user.name,
          phone: user.phone,
          token: UserPreferences.authToken ?? '',
          uuid: user.uuid,
          photoUrl: user.avatarUrl?.isNotEmpty == true ? user.avatarUrl : null,
          address: user.address?.isNotEmpty == true ? user.address : null,
          gender: user.gender?.isNotEmpty == true ? user.gender : null,
        );

        print('✅ Profile updated successfully');
        print('🖼️ New avatar: ${user.avatarUrl}');
        print('🚻 Gender: ${user.gender}');

        emit(PersonalInfoSuccess(userModel));
      } else {
        emit(PersonalInfoError(userModel.message ?? 'Update failed'));
      }
    } catch (e) {
      print('❌ Update avatar error: $e');

      String errorMessage = 'Gagal mengupdate profil';

      if (e.toString().contains('network') || e.toString().contains('socket')) {
        errorMessage = 'Tidak ada koneksi internet';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Koneksi timeout';
      }

      emit(PersonalInfoError(errorMessage));
    }
  }
}