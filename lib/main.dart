import 'package:app_mensajeria/presentation/providers/chat_provider.dart';
import 'package:app_mensajeria/presentation/providers/messages_provider.dart';
import 'package:app_mensajeria/presentation/providers/user_provider.dart';
import 'package:app_mensajeria/presentation/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
      ChangeNotifierProvider<MessagesProvider>(create: (context) => MessagesProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MyLoginScreen()),
    );
  }
}
