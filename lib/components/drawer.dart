import 'package:chat_app/services/auth/firebase_auth_service.dart';
import 'package:chat_app/components/drawer_list_tile.dart';
import 'package:flutter/material.dart';

class TheDrawer extends StatefulWidget {
  final String owner;
  const TheDrawer({super.key, required this.owner});

  @override
  State<TheDrawer> createState() => _TheDrawerState();
}

class _TheDrawerState extends State<TheDrawer> {
  //logout function
  void logout() {
    //getting auth service
    final authService = AuthService();
    //logging out user
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //spacing
              const SizedBox(
                height: 100,
              ),
              Text(
                widget.owner,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              //icon
              Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
              //list tiles
              //spacing
              const SizedBox(
                height: 40,
              ),
              //home ui
              DrawerListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  listText: "H O M E"),
              //settings
              DrawerListTile(
                  onTap: () {
                    //pop the drawer and go to settings page
                    Navigator.pop(context);
                    //push the settings page
                    Navigator.pushNamed(context, "/settings");
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  listText: "S E T T I N G S"),
            ],
          ),
          //logout
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DrawerListTile(
                onTap: () {
                  logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                listText: "L O G O U T"),
          ),
        ],
      ),
    );
  }
}
