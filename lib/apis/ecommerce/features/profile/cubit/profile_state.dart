part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}

class GetProfileFailureState extends ProfileState {
  final String errorMessage;

  GetProfileFailureState(this.errorMessage);
}