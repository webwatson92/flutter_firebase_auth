import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Fonction{

  Fonction._();

  static void flashSuccess(BuildContext context, couleur, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: couleur,
        ),
      );
  }
  
  static User? getCurrentUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    return user;
  }

}