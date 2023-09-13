part of 'e_home_cubit.dart';

@immutable
abstract class EHomeState {}

class EHomeInitial extends EHomeState {}

class EGetHomeSuccessState extends EHomeState {
  final dynamic data;

  EGetHomeSuccessState(this.data);
}

class EGetHomeFailureState extends EHomeState {
  final String errorMessage;

  EGetHomeFailureState(this.errorMessage);
}
