import 'package:auth/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

 
class _SignUpScreenState extends State<SignUpScreen> {
  
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

  _inscription() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email, 
        password: _password
      );
           
      print('Inscription effetuée: ${userCredential.user!.email}');
    } catch (e) {
      print("==email=="+_email + "===pass=== "+ _password);
      print("Une erreur est survenue lors de l'inscription : $e"); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte'),
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
                Text("Créer un compte", style: TextStyle(
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
                      _inscription();
                    }
                  }, 
                  child: Text('Créer votre compte')
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Avez-vous un compte ? "),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), 
                      child: 
                        Text("Connectez-vous !", style: TextStyle(color: Colors.blueAccent),
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
