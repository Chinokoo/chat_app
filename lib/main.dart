import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:chat_app/utils/check_network.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //load the .env file
  await dotenv.load(fileName: ".env");

  //ensure flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  if (await NetworkUtils.checkInternetConnection()) {
    //initialize firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(), child: MainApp()),
    );
  } else {
    runApp(ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: const OfflineApp()));
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      routes: {
        "/settings": (context) => const SettingsPage(),
      },
    );
  }
}

class OfflineApp extends StatelessWidget {
  const OfflineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Offline"),
        ),
      ),
    );
  }
}
