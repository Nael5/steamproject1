// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'delayed_animation.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Un e-mail a été envoyé avec des instructions pour réinitialiser votre mot de passe.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Une erreur s\'est produite. Veuillez vérifier votre adresse e-mail et réessayer.'),
          ),
        );
      }
    }
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
          actions: const <Widget>[],
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const DelayedAnimation(
                    delay: 200,
                    child: Text(
                      "Mot de passe oublié",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'GoogleSans1',
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const DelayedAnimation(
                    delay: 200,
                    child: Text(
                      "Veuillez saisir votre adresse mail \n afin de recevoir un nouveau mot de passe.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleSans6',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      filled: true,
                      fillColor: Colors.black45,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleSans6',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      //labelText: 'Adresse e-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer votre adresse e-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 120,
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
                          onPressed: _resetPassword,
                          child: const Text('Renvoyer mon mot de passe'),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
