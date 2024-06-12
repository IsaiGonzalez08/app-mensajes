import 'package:app_mensajeria/domain/models/User/user.dart';
import 'package:app_mensajeria/presentation/providers/chat_provider.dart';
import 'package:app_mensajeria/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_password_widget.dart';
import '../widgets/textfield_widget.dart';
import 'list_chats_screen.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  late UserModel _user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    print('Aqui voy desde login screen');
    final email = _emailController.text;
    final password = _passwordController.text;
    await Provider.of<UserProvider>(context, listen: false)
        .loginUser(email, password);
    print('regreso data del usuario');
    await providerListChats();
    navigateChatList();
  }

  Future<void> providerListChats() async {
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    final uid = _user.uid;
    await Provider.of<ChatProvider>(context, listen: false).getAllChats(uid);
  }

  void navigateChatList() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyListChatsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.055),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '¡Hola de Nuevo!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF272727)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Inicia sesión con tú cuenta',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA3A3A3)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextFieldWidget(
                text: 'Correo Electronico',
                width: 420,
                controllerTextField: _emailController),
            const SizedBox(
              height: 15,
            ),
            MyPasswordTextFieldWidget(
                text: 'Contraseña',
                width: 420,
                controllerTextField: _passwordController),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
                onPressed: () async {
                  await loginUser();
                },
                textButton: 'Entrar',
                width: 420,
                height: 40,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1C2541),
                colorText: const Color(0xFFFFFFFF)),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No tienes cuenta aún?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF797979)),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MySignUpScreen()));
                    },
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1C2541)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
