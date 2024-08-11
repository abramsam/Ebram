import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/cubit/bloc_Observer.dart';
import 'package:chat_app/cubit/chat_Cubit/cubit.dart';
import 'package:chat_app/cubit/login_Cubit/cubit.dart';
import 'package:chat_app/cubit/signup_Cubit/cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupCubit>(
          create: (context) {
            return SignupCubit();
          },
        ),
        BlocProvider<LoginCubit>(
          create: (context) {
            return LoginCubit();
          },),
        BlocProvider<ChatCubit>(
          create: (context) {
            return ChatCubit()..getMessages();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}