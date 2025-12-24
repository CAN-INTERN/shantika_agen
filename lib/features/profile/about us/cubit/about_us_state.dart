import 'package:equatable/equatable.dart';
import '../../../../model/about_us_model.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object?> get props => [];
}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  final About about;

  const AboutUsLoaded(this.about);

  @override
  List<Object?> get props => [about];
}

class AboutUsError extends AboutUsState {
  final String message;

  const AboutUsError(this.message);

  @override
  List<Object?> get props => [message];
}