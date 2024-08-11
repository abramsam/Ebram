import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/signup_Cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupStates>{
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);


  User? user;
  void signup ({required password, required email}) {
    emit(SignupLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      user = value.user;

      emit(SignupSuccessState());
    },
    onError: (error) {
      emit(SignupErrorState(error: error));
    });
  }
}