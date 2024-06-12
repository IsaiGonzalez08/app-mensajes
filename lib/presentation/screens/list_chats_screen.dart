import 'package:app_mensajeria/domain/models/User/user.dart';
import 'package:app_mensajeria/presentation/providers/chat_provider.dart';
import 'package:app_mensajeria/presentation/providers/messages_provider.dart';
import 'package:app_mensajeria/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class MyListChatsScreen extends StatefulWidget {
  const MyListChatsScreen({super.key});

  @override
  State<MyListChatsScreen> createState() => _MyListChatsScreenState();
}

class _MyListChatsScreenState extends State<MyListChatsScreen> {
  late UserModel _user;
  late String chatUid;
  late String userUid;
  late String name;
  late String lastname;

  String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return '$firstInitial$lastInitial';
  }

  Future<void> getMessagesList(
      String userUid, String name, String lastname, String chatId) async {
    await Provider.of<MessagesProvider>(context, listen: false)
        .getAllMessages(userUid, chatId);
    navigateChatScreen(chatId, name, lastname);
  }

  void navigateChatScreen(String uid, String name, String lastname) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyChatScreen(
            chatUid: uid,
            name: name,
            lastname: lastname,
          ),
        ));
  }

  @override
  void initState() {
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    userUid = _user.uid;
    name = _user.name;
    lastname = _user.lastname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chat',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF404040)),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF01142B),
                  child: Text(
                    getInitials(name, lastname),
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
              thickness: 0,
              indent: 0,
              endIndent: 0,
              color: Color(0xFF797979),
            ),
            Expanded(
              child: Consumer<ChatProvider>(builder: (_, controller, __) {
                final users = controller.chatList;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    final user = users[index];
                    return InkWell(
                      onTap: () {
                        final user = users[index];
                        final chatUid = user.uid;
                        final name = user.name;
                        final lastname = user.lastname;
                        getMessagesList(userUid, name, lastname, chatUid);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color(0xFFF5F5F5),
                          width: 2,
                        )),
                        height: 80,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xFF01142B),
                              child: Text(
                                getInitials(user.name, user.lastname),
                                style: const TextStyle(
                                    fontSize: 20, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.name} ${user.lastname}',
                                  style: const TextStyle(
                                      color: Color(0xFF222222),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: users.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
