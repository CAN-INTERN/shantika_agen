import 'package:equatable/equatable.dart';

import '../../../../model/privacy_policy_model.dart';

abstract class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();

  @override
  List<Object?> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState {}

class PrivacyPolicyLoading extends PrivacyPolicyState {}

class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final PrivacyPolicy privacyPolicy;

  const PrivacyPolicyLoaded(this.privacyPolicy);

  @override
  List<Object?> get props => [privacyPolicy];
}

class PrivacyPolicyError extends PrivacyPolicyState {
  final String message;

  const PrivacyPolicyError(this.message);

  @override
  List<Object?> get props => [message];
}