import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/about_us_repository.dart';
import 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  final AboutUsRepository _repository;

  AboutUsCubit(this._repository) : super(AboutUsInitial());

  Future<void> fetchAboutUs() async {
    try {
      emit(AboutUsLoading());
      final about = await _repository.getAboutUs();
      emit(AboutUsLoaded(about));
    } catch (e) {
      emit(AboutUsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> refreshAboutUs() async {
    await fetchAboutUs();
  }
}