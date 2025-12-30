part of 'personal_info_cubit.dart';

abstract class PersonalInfoState extends Equatable {
  const PersonalInfoState();

  @override
  List<Object?> get props => [];
}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoSuccess extends PersonalInfoState {
  final UserModel user;

  const PersonalInfoSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class PersonalInfoError extends PersonalInfoState {
  final String message;

  const PersonalInfoError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileRefreshed extends PersonalInfoState {
  final UserModel user;

  const ProfileRefreshed(this.user);

  @override
  List<Object?> get props => [user];
}