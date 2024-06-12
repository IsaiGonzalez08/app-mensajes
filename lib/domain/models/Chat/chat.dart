class ChatModel {
  String uid, name, lastname;

  ChatModel({
    this.uid = '',
    required this.name,
    required this.lastname,
  });

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
      uid: json['uid'] ?? '',
      name: json['name'],
      lastname: json['lastname'],
  );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'lastname': lastname,
    };
  }
}
