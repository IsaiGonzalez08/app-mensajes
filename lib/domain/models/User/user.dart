class UserModel {
  String uid, name, lastname, email;

  UserModel({
    this.uid = '',
    required this.name,
    required this.lastname,
    this.email = ''
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] ?? '',
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'] ?? ''
  );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'lastname': lastname,
      'email': email
    };
  }
}
