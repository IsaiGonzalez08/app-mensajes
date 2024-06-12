import 'dart:io';
import 'package:app_mensajeria/presentation/providers/chat_provider.dart';
import 'package:app_mensajeria/presentation/providers/messages_provider.dart';
import 'package:app_mensajeria/presentation/widgets/play_video_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

class MyChatScreen extends StatefulWidget {
  final String chatUid, name, lastname;
  const MyChatScreen({
    Key? key,
    required this.chatUid,
    required this.name,
    required this.lastname,
  }) : super(key: key);

  @override
  State<MyChatScreen> createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {
  late String chatUid;
  String? imgUrl;
  String? audioUrl;
  String? videoUrl;
  late String name;
  late String lastname;
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    chatUid = widget.chatUid;
    imgUrl = null;
    audioUrl = null;
    videoUrl = null;
    super.initState();
  }

  String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return '$firstInitial$lastInitial';
  }

  Future<void> _sendMessage(String chatId, {String? imgUrl, String? audioUrl, String? videoUrl}) async {
    final message = _messageController.text;
    if (message.isNotEmpty || (imgUrl != null && imgUrl.isNotEmpty) || (audioUrl != null && audioUrl.isNotEmpty) || (videoUrl != null && videoUrl.isNotEmpty)) {
      if (mounted) {
        print('Enviando mensaje con imgUrl: $imgUrl, audioUrl: $audioUrl, videoUrl: $videoUrl');
        Provider.of<ChatProvider>(context, listen: false)
            .createMessage(chatId, message, imgUrl ?? '', audioUrl ?? '', videoUrl ?? '');
        setState(() {
          _messageController.clear();
          this.imgUrl = null;
          this.audioUrl = null;
          this.videoUrl = null;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      imgUrl = await uploadFile(file, 'chat_images');
      if (imgUrl != null) {
        _sendMessage(chatUid, imgUrl: imgUrl);
      }
    }
  }

  Future<void> _pickAudio() async {

    if (await Permission.storage.request().isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null) {
        File file = File(result.files.single.path!);
        audioUrl = await uploadFile(file, 'audio');
        if (audioUrl != null) {
          _sendMessage(chatUid, audioUrl: audioUrl);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso para acceder al almacenamiento denegado')),
      );
    }
  }

  Future<void> _pickVideo() async {
    // Solicitar permiso antes de acceder al almacenamiento
    if (await Permission.storage.request().isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
      if (result != null) {
        File file = File(result.files.single.path!);
        videoUrl = await uploadFile(file, 'video');
        if (videoUrl != null) {
          _sendMessage(chatUid, videoUrl: videoUrl);
        }
      }
    } else {
      // Mostrar un mensaje al usuario indicando que el permiso es necesario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso para acceder al almacenamiento denegado')),
      );
    }
  }

  Future<String?> uploadFile(File file, String fileType) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('$fileType/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await storageRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      print('URL desde el método upload: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error al subir archivo: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessagesProvider>(
              builder: (_, controller, __) {
                final messages = controller.messagesList;
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.imgUrl.isNotEmpty)
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(message.imgUrl),
                            ),
                          if (message.audioUrl != null && message.audioUrl!.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.audiotrack),
                                IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () async {
                                    AudioPlayer player = AudioPlayer();
                                    await player.play(UrlSource(message.audioUrl!));
                                  },
                                ),
                              ],
                            ),
                          if (message.videoUrl != null && message.videoUrl!.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.videocam),
                                IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => VideoPlayerDialog(videoUrl: message.videoUrl!),
                                    );
                                  },
                                ),
                              ],
                            ),
                          if (message.content.isNotEmpty)
                            Text(
                              message.content,
                              style: const TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: const Icon(Icons.audiotrack),
                  onPressed: _pickAudio,
                ),
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: _pickVideo,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(chatUid);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}