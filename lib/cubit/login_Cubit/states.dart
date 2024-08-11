abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginInLoadingState extends LoginStates {}
class LoginInSuccessState extends LoginStates {}
class LoginInErrorState extends LoginStates {
  String error;
  LoginInErrorState({required this.error});
}