import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/cubit/chat_Cubit/cubit.dart';
import 'package:chat_app/cubit/chat_Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  CollectionReference subject = FirebaseFirestore.instance.collection('subject');
  bool isI = true;
  List<Map>? messages;

  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);

    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (BuildContext context, ChatStates state) {
        if((state is ChatAddMessageErrorState) || (state is ChatGetMessageErrorState)) {
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
            title: 'Fail to send the message',
            desc: '',
            showCloseIcon: true,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (BuildContext context, ChatStates state) {
        this.messages = cubit.messages;

        return Scaffold(
          backgroundColor: Colors.white24,
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: const Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage("assets/chat avatar.png"),
                    ),
                    CircleAvatar(
                      radius: 7.0,
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      radius: 6.0,
                      backgroundColor: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Samanta",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  isI = !isI;
                },
                icon: const Icon(
                  Icons.more_vert,
                  size: 30.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            Map? message = messages?[index];
                            return message?["isI"] == "true" ? IamSpeaking(
                              time: message?["time"],
                              message: message?["message"],
                            ) : anotherOneSpeaking(
                              time: message?["time"],
                              message: message?["message"],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20.0,
                            );
                          },
                          itemCount: messages!.length,
                        ),
                      ),
                    ],
                  ),
                ),
                defaultTextFormField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  hintText: "Type your message ......",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  labelText: "Type your message ......",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions_outlined),
                  ),
                  prefixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        // todo
                        print("message: ${messageController.text}");

                        cubit.addMessage(
                          message: messageController.text,
                          time: DateTime.now().toString(),
                          isI: isI ? "true" : "false",
                        );

                        messageController.text = "";
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                  suffixIconColor: Colors.grey,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
