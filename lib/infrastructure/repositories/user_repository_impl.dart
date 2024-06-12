import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/User/repository/user_repository.dart';
import '../../domain/models/User/user.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> loginUser(String email, String password) async {
    try {
      print('voy desde el implements');
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {   
        print('user no es null');
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          UserModel userModel =
              UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          print('Usuario existe, login correcto, regresando data del user');
          return userModel;
        }
      }
    } catch (e) {
      throw ('El error es $e');
    }
    throw ('User not found');
  }

  @override
  Future<void> createUser(
      String name, String lastname, String email, String password) async {
    try {
      print('voy desde el implements');
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print('Aqui voy userCredential: $userCredential');
      print('Aqui voy user: $user');

      if (user != null) {
        print('User ID: ${user.uid}');
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'lastname': lastname,
          'email': email,
        });
        print('User data saved in Firestore');
      } else {
        print('User is null');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('FirebaseAuthException: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
