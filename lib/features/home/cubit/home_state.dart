import 'package:equatable/equatable.dart';
import 'package:shantika_agen/model/agency_model.dart';
import 'package:shantika_agen/model/time_classification_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Agency> agencies;

  const HomeLoaded(this.agencies);

  @override
  List<Object?> get props => [agencies];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class TimeClassificationLoading extends HomeState {}

class TimeClassificationLoaded extends HomeState {
  final List<Time> timeClassifications;

  const TimeClassificationLoaded(this.timeClassifications);

  @override
  List<Object?> get props => [timeClassifications];
}

class TimeClassificationError extends HomeState {
  final String message;

  const TimeClassificationError(this.message);

  @override
  List<Object?> get props => [message];
}