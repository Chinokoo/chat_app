import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/firebase_auth_service.dart';
import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //chat and auth services
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  void logout() {
    //getting auth service
    final authService = AuthService();
    //logging out user
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: TheDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          //return List view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual user list item
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all the users except for the current logged in user
    return UserTile(
      onTap: () {
        //tapped on user -> go to chat page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      recieversEmail: userData['email'],
                    )));
      },
      text: userData['email'],
    );
  }
}
