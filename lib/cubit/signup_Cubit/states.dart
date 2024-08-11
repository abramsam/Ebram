abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}
class SignupSuccessState extends SignupStates {}
class SignupErrorState extends SignupStates {
  String error;
  SignupErrorState({required this.error});
}