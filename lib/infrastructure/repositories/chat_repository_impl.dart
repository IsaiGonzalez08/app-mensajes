import 'package:app_mensajeria/domain/models/Chat/chat.dart';
import 'package:app_mensajeria/domain/models/Chat/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<List<ChatModel>> getAllChats(String uid) async {
    var listChats = <ChatModel>[];
    try {
      print('Aqui voy en el implemts para obtener los chats');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('chats')
          .get();
      print('Los snapshot son ${snapshot.docs.indexed}');
      snapshot.docs.forEach((element) {
        listChats
            .add(ChatModel.fromMap(element.data() as Map<String, dynamic>));
      });

      print('Estoy en la lista de usuarios $listChats');
      return listChats;
    } catch (e, stackTrace) {
      print('Error al obtener chats: $e');
      print('Stack trace: $stackTrace');
      throw e;
    }
  }

  @override
  Future<void> createMessage(String chatId, String message, String imgUrl, String? audioUrl, String? videoUrl) async {
    print('alla voy desde el implements');
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final chatUid = chatId;
      final CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(chatUid)
          .collection('messages');
      await messagesRef.add({
        'content': message,
        'senderId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'imgUrl': imgUrl,
        'audioUrl': audioUrl,
        'videoUrl': videoUrl
      });
      print('El mensaje que se agrego es: $message');
      print('Mensaje agregado a la entidad mensajes');
    }
  }
}
