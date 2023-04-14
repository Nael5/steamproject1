// ignore_for_file: unused_local_variable, avoid_print, duplicate_ignore, prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, unused_import

import 'delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'api3.dart';
import 'api.dart';
import 'reset_password.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

const white = Color(0xFFFFFFFF);

class WelcomePage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    const DelayedAnimation(
                      delay: 200,
                      child: Text(
                        'Bienvenue !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GoogleSans1',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DelayedAnimation(
                      delay: 200,
                      child: Text(
                        " Veuillez vous connecter \n ou créer un compte \n pour accéder à l'application.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'GoogleSans6',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    DelayedAnimation(
                      delay: 400,
                      child: TextField(
                        controller: emailController,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          filled: true,
                          fillColor: Colors
                              .black45, // Définir la couleur de fond en noir
                          // ignore: prefer_const_constructors
                          hintStyle: TextStyle(
                            color: Colors
                                .white, // Définir la couleur de texte en blanc
                            fontSize: 14,
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
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Mot de passe',
                          filled: true,
                          fillColor: Colors.black45,
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    DelayedAnimation(
                      delay: 600,
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(99, 106, 246, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            child: Text('Se connecter'),
                            onPressed: () async {
                              try {
                                UserCredential userCredential =
                                    await _auth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Accueil()),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print(
                                      'Aucun utilisateur trouvé pour cet e-mail.');
                                } else if (e.code == 'wrong-password') {
                                  // ignore: avoid_print
                                  print('Le mot de passe est incorrect.');
                                }
                              }
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DelayedAnimation(
                      delay: 700,
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(
                              color: Color.fromRGBO(99, 106, 246, 1),
                              width: 0.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Créer un nouveau compte'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Inscription(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    DelayedAnimation(
                      delay: 800,
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black45.withOpacity(0.0),
                          ),
                          child: const Text('mot de passe oublié',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                              )),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordResetPage()),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
