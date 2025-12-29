import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/faq_repository.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FaqRepository _repository;

  FaqCubit(this._repository) : super(FaqInitial());

  Future<void> fetchFaqs() async {
    try {
      emit(FaqLoading());
      final faqs = await _repository.getFaqs();
      emit(FaqLoaded(faqs));
    } catch (e) {
      emit(FaqError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> refreshFaqs() async {
    await fetchFaqs();
  }
}