import 'package:app_mensajeria/presentation/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_password_widget.dart';
import 'login_screen.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({super.key});

  @override
  State<MySignUpScreen> createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateLoginScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyLoginScreen()));
  }

  Future<void> createUser() async {
    final name = _nameController.text;
    final lastname = _lastnameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    print('alla voy');
    await Provider.of<UserProvider>(context, listen: false)
        .createUser(name, lastname, email, password);
    navigateLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  'Crea una cuenta',
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
                    'Solo tomara unos minutos',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextFieldWidget(
                    text: 'Nombre',
                    width: 175,
                    controllerTextField: _nameController),
                const SizedBox(
                  width: 15,
                ),
                MyTextFieldWidget(
                    text: 'Apellido',
                    width: 175,
                    controllerTextField: _lastnameController),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextFieldWidget(
                text: 'Correo Electrónico',
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
              height: 20,
            ),
            ButtonWidget(
                onPressed: () async {
                  await createUser();
                },
                textButton: 'Entrar',
                width: 420,
                height: 40,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1C2541),
                colorText: const Color(0xFFFFFFFF)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Ya tienes cuenta?,',
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
                              builder: (context) => const MyLoginScreen()));
                    },
                    child: const Text(
                      'inicia sesión aquí.',
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
