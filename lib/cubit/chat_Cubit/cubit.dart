import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/chat_Cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates>{
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  CollectionReference chat = FirebaseFirestore.instance.collection('chat');
  void addMessage({
    required String message,
    required String time,
    required String isI,
  }) {
    emit(ChatAddMessageLoadingState());
    // Call the user's CollectionReference to add a new user
    this.chat.add({
      "message": message,
      "time" : time,
      "isI" : isI,
    }).then((value) {
      print("Message Added");

      emit(ChatAddMessageSuccessState());

      getMessages();
    }).catchError((error) {
      print("Failed to add message: $error");

      emit(ChatAddMessageErrorState(error: error));
    });
  }

  List<Map> messages = [];
  void getMessages() {
    emit(ChatGetMessageLoadingState());
    // Reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the collection you want to retrieve data from
    CollectionReference collectionRef = firestore.collection('chat');

    // Fetch all documents in the collection
    collectionRef.get().then((value) {
      this.messages = [];
      value.docs.forEach((doc) {
        // Print document ID and its data
        print('Document ID: ${doc.id}');
        print('Document Data: ${doc.get("message")}');

        messages.add({
          "id" : doc.id,
          "message" : doc.get("message"),
          "time" : doc.get("time"),
          "isI" : doc.get("isI"),
        });
      });

      emit(ChatGetMessageSuccessState());
    },
    onError: (error) {
      print("Error in get messages : $error");

      emit(ChatGetMessageErrorState(error: error));
    });
  }
}