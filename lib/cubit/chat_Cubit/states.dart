abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatAddMessageLoadingState extends ChatStates {}
class ChatAddMessageSuccessState extends ChatStates {}
class ChatAddMessageErrorState extends ChatStates {
  String error;
  ChatAddMessageErrorState({required this.error});
}

class ChatGetMessageLoadingState extends ChatStates {}
class ChatGetMessageSuccessState extends ChatStates {}
class ChatGetMessageErrorState extends ChatStates {
  String error;
  ChatGetMessageErrorState({required this.error});
}

