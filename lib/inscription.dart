// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, prefer_const_literals_to_create_immutables, empty_catches, unnecessary_null_comparison, unused_element, unused_import

import 'delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api.dart';

class Inscription extends StatelessWidget {
  Inscription({super.key});

  final _auth = FirebaseAuth.instance;

  Future<void> _createUserAccount(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Connexion.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            alignment: Alignment.center,
            child: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginForm(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isPasswordMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text(
              'Inscription',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: 'GoogleSans1',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              ' Veuillez saisir ces différentes informations, \n afin que vos listes soient sauvegardées.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GoogleSans6',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const DelayedAnimation(
              delay: 500,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Nom d'utilisateur",
                  filled: true,
                  fillColor: Colors.black45,
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'GoogleSans6',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedAnimation(
              delay: 500,
              child: TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'E-Mail',
                  filled: true,
                  fillColor: Colors.black45,
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'GoogleSans6',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedAnimation(
              delay: 300,
              child: TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black45,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'GoogleSans6',
                  ),
                  labelText: 'Mot de passe',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedAnimation(
              delay: 300,
              child: TextField(
                controller: _confirmPasswordController,
                textAlign: TextAlign.center,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black45,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'GoogleSans6',
                  ),
                  labelText: 'Confirmation du mot de passe',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            if (!_isPasswordMatch()) // Afficher un message d'erreur si les mots de passe ne sont pas identiques
              const Text('Les mots de passe ne correspondent pas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
            const SizedBox(
              height: 40,
            ),
            DelayedAnimation(
              delay: 1000,
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(99, 106, 246, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text("S'inscrire"),
                  onPressed: () async {
                    //String email = _emailController.text;
                    //String password = _passwordController.text;
                    try {
                      // Créer une nouvelle authentification sur Firebase
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      // Si l'authentification est réussie, affichez un message de succès
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Authentification réussie avec succès'),
                          duration: Duration(seconds: 3),
                        ),
                      );

                      // Rediriger l'utilisateur vers une autre page après l'authentification réussie
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Accueil()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Si l'authentification échoue, affichez un message d'erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erreur: ${e.message}'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  //Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => SocialPage(),}
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
