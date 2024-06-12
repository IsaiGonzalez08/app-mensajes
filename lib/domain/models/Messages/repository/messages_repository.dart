import 'package:app_mensajeria/domain/models/Messages/messages.dart';

abstract class MessagesRepository {
  Future<List<MessagesModel>> getAllMessages(String uid, String chatUid);
}
