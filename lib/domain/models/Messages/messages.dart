import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel {
  String content, senderId;
  Timestamp timestamp;
  String imgUrl;
  String? audioUrl;
  String? videoUrl;


  MessagesModel({
    this.content = '',
    required this.senderId,
    required this.timestamp,
    this.imgUrl = '',
    this.audioUrl,
    this.videoUrl
  });

  factory MessagesModel.fromMap(Map<String, dynamic> json) => MessagesModel(
        content: json['content'] ?? '',
        senderId: json['senderId'],
        timestamp: json['timestamp'],
        imgUrl: json['imgUrl'] ?? '',
        audioUrl: json['audioUrl'],
        videoUrl: json['videoUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
      'imgUrl': imgUrl,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
    };
  }
}
