// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:steamproject1/api3.dart';
import 'recherche.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 35, 32, 32),
      ),
      home: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          title: const Text('Accueil'),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset('assets/icones/like.svg'),
              color: Colors.white,
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: SvgPicture.asset('assets/icones/whishlist.svg'),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            //height: MediaQuery.of(context).size.height / 2,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Api2()),
                  );
                },
                child: const Text(
                  'Rechercher un jeu',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/titan.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Titan Fall 2                         \nUltimate Edition',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          ' Une description d un jeu mis en avant  \n(un peu dur)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(99, 106, 246, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('En savoir plus',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SingleChildScrollView(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(99, 106, 246, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Api()),
                );
              },
              child: const Text('Voir la liste des 100 jeux les plus joués',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
