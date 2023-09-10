abstract class ELoginState {}

class ELoginInitial extends ELoginState {}

class ELoginSuccessState extends ELoginState {}

class ELoginFailureState extends ELoginState {
  final String errorMessage;

  ELoginFailureState(this.errorMessage);
}
