import 'package:equatable/equatable.dart';

import '../../../../model/terms_condition_model.dart';

abstract class TermsConditionState extends Equatable {
  const TermsConditionState();

  @override
  List<Object?> get props => [];
}

class TermsConditionInitial extends TermsConditionState {}

class TermsConditionLoading extends TermsConditionState {}

class TermsConditionLoaded extends TermsConditionState {
  final TermAndCondition termsCondition;

  const TermsConditionLoaded(this.termsCondition);

  @override
  List<Object?> get props => [termsCondition];
}

class TermsConditionError extends TermsConditionState {
  final String message;

  const TermsConditionError(this.message);

  @override
  List<Object?> get props => [message];
}