import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/terms_condition_repository.dart';
import 'terms_condition_state.dart';

class TermsConditionCubit extends Cubit<TermsConditionState> {
  final TermsConditionRepository _repository;

  TermsConditionCubit(this._repository) : super(TermsConditionInitial());

  Future<void> fetchTermsCondition() async {
    try {
      emit(TermsConditionLoading());
      final termsCondition = await _repository.getTermsCondition();
      emit(TermsConditionLoaded(termsCondition));
    } catch (e) {
      emit(TermsConditionError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> refreshTermsCondition() async {
    await fetchTermsCondition();
  }
}