import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/cubit/signup_Cubit/cubit.dart';
import 'package:chat_app/cubit/signup_Cubit/states.dart';
import 'package:chat_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  bool isAgree = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (BuildContext context, SignupStates state) {
        if(state is SignupSuccessState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
            width: 280,
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            onDismissCallback: (type) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dismissed by $type'),
                ),
              );
            },
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Success',
            desc: '',
            showCloseIcon: true,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
          navigateTo(context, ChatScreen());

        } else if(state is SignupErrorState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
            width: 280,
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            onDismissCallback: (type) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dismissed by $type'),
                ),
              );
            },
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Fail',
            desc: '',
            showCloseIcon: true,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (BuildContext context, SignupStates state) {
        SignupCubit cubit = SignupCubit.get(context);

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white24,
            body: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          // full name
                          defaultTextFormField(
                            controller: nameController,
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            labelText: "Full name",
                            hintText: "Full name",
                            keyboardType: TextInputType.text,
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            validator: (String? value){
                              if(value!.isEmpty){
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // E-mail
                          defaultTextFormField(
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: "E-mail",
                            hintText: "E-mail",
                            keyboardType: TextInputType.emailAddress,
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            validator: (String? value){
                              if(value!.isEmpty){
                                return "Please enter your E-mail";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // Password
                          defaultTextFormField(
                            controller: passwordController,
                            prefixIcon: const Icon(Icons.password_outlined),
                            labelText: "Password",
                            hintText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureTextPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextPassword =!obscureTextPassword;
                                });
                              },
                              icon: obscureTextPassword ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            validator: (String? value){
                              if(value!.isEmpty){
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // Confirm password
                          defaultTextFormField(
                            controller: confirmPasswordController,
                            prefixIcon: const Icon(Icons.password_outlined),
                            labelText: "Confirm password",
                            hintText: "Confirm password",
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureTextConfirmPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextConfirmPassword =!obscureTextConfirmPassword;
                                });
                              },
                              icon: obscureTextConfirmPassword ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            validator: (String? value){
                              if(value!.isEmpty || value!= confirmPasswordController.text){
                                return "Please enter your confirmation password correctly";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          // Agreement
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isAgree = !isAgree;
                                  });
                                },
                                icon: isAgree ? const Icon(
                                  Icons.check_box_outlined,
                                  color: Colors.white,
                                ) : const Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 3.0,
                              ),
                              const Text(
                                "I Agree With",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              const Text(
                                "privacy",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              const Text(
                                "and",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              const Text(
                                "policy",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60.0,
                          ),
                          // Signup button
                          state is SignupLoadingState ? const CircularProgressIndicator(
                            color: Colors.redAccent,
                          ) : Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if(formKey.currentState!.validate() && isAgree){
                                  print("Email : ${this.nameController.text}");
                                  print("E-mail : ${this.emailController.text}");
                                  print("Password : ${this.passwordController.text}");

                                  cubit.signup(
                                    password: passwordController.text,
                                    email: emailController.text,
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, const LoginScreen());
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
    }
    );
  }
}
