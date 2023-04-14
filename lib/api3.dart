import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'delayed_animation.dart';
import 'recherche.dart';

Future<List<Rank>> fetchGames() async {
  try {
    final response = await http.get(
      Uri.https(
          'api.steampowered.com', '/ISteamChartsService/GetMostPlayedGames/v1'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    if (response.statusCode == 200) {
      return await _getGameDetails(
          Games.fromJson(jsonDecode(response.body)).ranks);
    } else {
      throw Exception('Failed to load games: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load games: $e');
  }
}

Future<List<Rank>> _getGameDetails(List<Rank> ranks) async {
  List<Rank> updatedRanks = [];
  for (var rank in ranks) {
    final response = await http.get(
      Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=${rank.appId}'),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody[rank.appId.toString()]['success']) {
        rank.name = jsonBody[rank.appId.toString()]['data']['name'];
      }
    }
    updatedRanks.add(rank);
  }
  return updatedRanks;
}

class Games {
  final int rollupDate;
  final List<Rank> ranks;

  Games({
    required this.rollupDate,
    required this.ranks,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      rollupDate: json['response']['rollup_date'],
      ranks: List<Rank>.from(
        json['response']['ranks'].map(
          (rankJson) => Rank.fromJson(rankJson),
        ),
      ),
    );
  }
}

class Rank {
  final int rank;
  final int appId;
  final int lastWeekRank;
  final int peakInGame;
  String? name;

  Rank({
    required this.rank,
    required this.appId,
    required this.lastWeekRank,
    required this.peakInGame,
    this.name,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      rank: json['rank'],
      appId: json['appid'],
      lastWeekRank: json['last_week_rank'],
      peakInGame: json['peak_in_game'],
      name: json['name'],
    );
  }
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  late Future<List<Rank>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
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
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            alignment: Alignment.center,
            child: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DelayedAnimation(
                      delay: 200,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Api2()),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('les meilleurs ventes',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    Center(
                      child: FutureBuilder<List<Rank>>(
                        future: futureGames,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final ranks = snapshot.data!;
                            return ListView.builder(
                              itemCount: ranks.length,
                              itemBuilder: (context, index) {
                                final rank = ranks[index];
                                return ListTile(
                                  title: Text('${rank.rank}. ${rank.name}'),
                                  subtitle:
                                      Text('Peak In Game: ${rank.peakInGame}'),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
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
