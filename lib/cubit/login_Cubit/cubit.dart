import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/login_Cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  User? user;
  void signin ({required password, required email}) {
    emit(LoginInLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      user = value.user;

      emit(LoginInSuccessState());
    },
    onError: (error) {
      emit(LoginInErrorState(error: error));
    });
  }
}