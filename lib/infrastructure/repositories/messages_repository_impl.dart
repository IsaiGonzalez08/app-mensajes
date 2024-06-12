import 'package:app_mensajeria/domain/models/Messages/messages.dart';
import 'package:app_mensajeria/domain/models/Messages/repository/messages_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesRepositoryImpl extends MessagesRepository {
  @override
  Future<List<MessagesModel>> getAllMessages(String uid, String chatUid) async {
    var listMessages = <MessagesModel>[];
    try {
      print('Aqui voy en el implemts para obtener los mensajes');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('chats')
          .doc(chatUid)
          .collection('messages')
          .get();
      snapshot.docs.forEach((element) {
        listMessages
            .add(MessagesModel.fromMap(element.data() as Map<String, dynamic>));
      });
      print('la lista de mensajes regresa: $listMessages');
      for (var i in listMessages) {
        print('El mensaje es: ${i.content}');
        
      }
      return listMessages;
    } catch (e, stackTrace) {
      print('Error al obtener chats: $e');
      print('Stack trace: $stackTrace');
      throw e;
    }
  }
}
