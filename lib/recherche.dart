// ignore_for_file: unused_field, unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<List<Rank>> fetchGames1({String? searchTerm}) async {
  try {
    final response = await http.get(
      Uri.https('api.steampowered.com',
          '/ISteamChartsService/GetMostPlayedGames/v1', {
        'format': 'json',
        'limit': '100',
      }),
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
      final games = Games.fromJson(jsonDecode(response.body)).ranks;
      if (searchTerm != null && searchTerm.isNotEmpty) {
        return games
            .where((game) =>
                game.name?.toLowerCase().contains(searchTerm.toLowerCase()) ??
                false)
            .toList();
      } else {
        return games;
      }
    } else {
      throw Exception('Failed to load games: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load games: $e');
  }
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

class Api2 extends StatefulWidget {
  const Api2({Key? key}) : super(key: key);

  @override
  State<Api2> createState() => _Api2State();
}

class _Api2State extends State<Api2> {
  late Future<List<Rank>> futureGames1;
  final _searchController = TextEditingController();
  List<Rank> _filteredRanks = [];

  @override
  void initState() {
    super.initState();
    futureGames1 = fetchGames1();
  }

////////////////////////////////////////////////////////////////////////////////////
  void _filterRanks(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      _filteredRanks = futureGames1.then((ranks) {
        return ranks
            .where((rank) =>
                rank.name?.toLowerCase().contains(lowerCaseQuery) ?? false)
            .toList();
      }) as List<Rank>;
    });
  }

////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 35, 32, 32),
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Recherche'),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Rechercher un jeu',
                  hintText: 'Rechercher un jeu',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Expanded(
                child: FutureBuilder<List<Rank>>(
                  future: futureGames1,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final ranks = snapshot.data!;
                      final filteredRanks = ranks.where((rank) => rank.name!
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));
                      return ListView.builder(
                        itemCount: filteredRanks.length,
                        itemBuilder: (context, index) {
                          final rank = filteredRanks.elementAt(index);
                          return ListTile(
                            title: Text('${rank.rank}. ${rank.name}'),
                            subtitle: Text('Peak In Game: ${rank.peakInGame}'),
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
            ],
          ),
        ),
      ),
    );
  }
}
