import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_agen/features/profile/privacy_policy/cubit/privacy_policy_state.dart';

import '../../../../repository/privacy_policy_repository.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final PrivacyPolicyRepository repository;

  PrivacyPolicyCubit(this.repository) : super(PrivacyPolicyInitial());

  Future<void> fetchPrivacyPolicy() async {
    try {
      emit(PrivacyPolicyLoading());

      final privacyPolicy = await repository.getPrivacyPolicy();
      emit(PrivacyPolicyLoaded(privacyPolicy));
    } catch (e) {
      emit(PrivacyPolicyError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}