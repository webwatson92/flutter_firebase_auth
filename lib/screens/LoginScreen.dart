import 'package:auth/screens/HomePage.dart';
import 'package:auth/screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

 
class _LoginScreenState extends State<LoginScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passController = TextEditingController();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  _connexion() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email, 
        password: _password
      );
      Navigator.push(context, 
       MaterialPageRoute(builder: (context) =>  HomePage())
      );

      print('Vous êtes connecté : ${userCredential.user!.email}');
    } catch (e) {
      print("==email=="+_email + "===pass=== "+ _password);
      print("Une erreur est survenue lors de la connexion : $e"); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Connexion", style: TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blue
                ),),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return "Veuillez renseigner le champ email";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mot de passe",
                  ),
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return "Veuillez renseigner le champ mot de passe";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _connexion();
                    }
                  }, 
                  child: Text('Je me connecte')
                ),
                SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vous n'avez pas de compte ?"),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUpScreen()));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), 
                        child: 
                          Text("Créer maintenant!", style: TextStyle(color: Colors.blueAccent),
                          ),
                        ), 
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
