import 'package:firebase_auth/firebase_auth.dart';

class Fonction{

  static User? getCurrentUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    return user;
  }

}