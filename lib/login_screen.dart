import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/cubit/login_Cubit/cubit.dart';
import 'package:chat_app/cubit/login_Cubit/states.dart';
import 'package:chat_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  bool isRemember = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if(state is LoginInSuccessState)
          {
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

          } else if(state is LoginInErrorState) {
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
        builder: (BuildContext context, LoginStates state) {
          LoginCubit cubit = LoginCubit.get(context);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Login",
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
                        controller: emailController,
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        labelText: "E-mail",
                        hintText: "E-mail",
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
                      // Password
                      defaultTextFormField(
                        controller: passwordController,
                        prefixIcon: const Icon(Icons.password_outlined),
                        labelText: "Password",
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText =!obscureText;
                            });
                          },
                          icon: obscureText ? const Icon(Icons.visibility)
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
                        height: 40.0,
                      ),
                      // Remember me
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isRemember = !isRemember;
                                    });
                                  },
                                  icon: isRemember ? const Icon(
                                    Icons.check_box_outlined,
                                    color: Colors.white,
                                  ) : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      // Signup button
                      state is LoginInLoadingState ? const CircularProgressIndicator(
                        color: Colors.redAccent,
                      ) : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()) {
                              print("User name : ${this.emailController.text}");
                              print("Password : ${this.passwordController.text}");
                            }

                            cubit.signin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      // Sign in options
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Or Sign in with",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/Facebook-Logosu.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Image.asset(
                                  "assets/twitter.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Image.asset(
                                  "assets/google.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Image.asset(
                                  "assets/Instagram.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
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
                                    navigateTo(context, const SignupScreen());
                                  },
                                  child: const Text(
                                    "Sign Up",
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
