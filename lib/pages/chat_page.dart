import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/firebase_auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //controller
  final TextEditingController messageController = TextEditingController();
  //chat & auth services
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  //text field focus node
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listener to text field focus node
    textFieldFocusNode.addListener(() {
      //cause a delay so that keyboard shows up
      //then the amount of remaining space will be calculated.
      //then scroll down to the bottom of the list.
      Future.delayed(
        const Duration(milliseconds: 500),
        () => scrollDown(),
      );
    });
    //wait a bit for listview to be built, then scroll to the bottom.
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  //final scroll controller
  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //sending message function
  void sendMessage() async {
    //if there is something in the text field - send message.
    if (messageController.text.isNotEmpty) {
      //send the message
      await chatService.sendMessage(messageController.text, widget.receiverID);
    }
    //clear the text field
    messageController.clear();
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 61, 61, 61),
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(
            widget.receiverEmail,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),

          //user input
          _buildMessageInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(senderID, widget.receiverID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //return List view.
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user.
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;

    //align message to the right if it's the current user., otherwise align to the left.
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    //return message item.
    return Container(
        alignment: alignment,
        child: Column(children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ]));
  }

  //widget message input
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          //text field take up most space.
          Expanded(
            child: TheTextField(
                focusNode: textFieldFocusNode,
                controller: messageController,
                hinText: "Enter message",
                obscureText: false),
          ),
          InkWell(
            hoverColor: Theme.of(context).colorScheme.secondary,
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: sendMessage,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
