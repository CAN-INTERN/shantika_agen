import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/agency_model.dart';
import '../../../model/time_classification_model.dart';
import '../../../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;
  List<Agency> _allAgencies = [];
  List<Time> _allTimeClassifications = [];

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> fetchAgencies() async {
    try {
      emit(HomeLoading());
      final agencies = await _repository.getAgencies();

      if (isClosed) return; // Add this check

      if (agencies.isNotEmpty) {
        _allAgencies = agencies;
        emit(HomeLoaded(agencies));
      } else {
        emit(const HomeError('No agencies available'));
      }
    } catch (e) {
      if (!isClosed) { // Add this check
        emit(HomeError(e.toString()));
      }
    }
  }

  void searchAgencies(String query) {
    if (_allAgencies.isEmpty || isClosed) return; // Add isClosed check

    if (query.isEmpty) {
      emit(HomeLoaded(_allAgencies));
    } else {
      final filtered = _allAgencies.where((agency) {
        final agencyName = (agency.agencyName ?? '').toLowerCase();
        final cityName = (agency.cityName ?? '').toLowerCase();
        final searchLower = query.toLowerCase();

        return agencyName.contains(searchLower) || cityName.contains(searchLower);
      }).toList();

      emit(HomeLoaded(filtered));
    }
  }

  Future<void> refreshAgencies() async {
    await fetchAgencies();
  }

  Future<void> fetchTimeClassifications() async {
    try {
      emit(TimeClassificationLoading());
      final timeClassifications = await _repository.getTimeClassification();

      if (isClosed) return; // Add this check

      if (timeClassifications.isNotEmpty) {
        _allTimeClassifications = timeClassifications;
        emit(TimeClassificationLoaded(timeClassifications));
      } else {
        emit(const TimeClassificationError('No time classifications available'));
      }
    } catch (e) {
      if (!isClosed) { // Add this check
        emit(TimeClassificationError(e.toString()));
      }
    }
  }

  void searchTimeClassifications(String query) {
    if (_allTimeClassifications.isEmpty || isClosed) return; // Add isClosed check

    if (query.isEmpty) {
      emit(TimeClassificationLoaded(_allTimeClassifications));
    } else {
      final filtered = _allTimeClassifications.where((time) {
        final timeName = (time.name ?? '').toLowerCase();
        final searchLower = query.toLowerCase();

        return timeName.contains(searchLower);
      }).toList();

      emit(TimeClassificationLoaded(filtered));
    }
  }

  Future<void> refreshTimeClassifications() async {
    await fetchTimeClassifications();
  }
}