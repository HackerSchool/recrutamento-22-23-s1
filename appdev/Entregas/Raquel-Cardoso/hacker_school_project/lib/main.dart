import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Top 100 Anilist Anime Names',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 180, 99, 255),
              foregroundColor: Color.fromARGB(255, 17, 6, 16)),
        ),
        home: AnimatedSplashScreen(
            duration: 1800,
            splash: Icons.airline_stops_sharp,
            nextScreen: const AnimeNames(),
            splashTransition: SplashTransition.rotationTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Color.fromARGB(255, 180, 99, 255)));
  }
}

class AnimeNames extends StatefulWidget {
  const AnimeNames({super.key});

  @override
  State<AnimeNames> createState() => _AnimeNamesState();
}

class _AnimeNamesState extends State<AnimeNames> {
  final _suggestions = <String>[];
  final _watched = <String>{};
  final _biggerFont = const TextStyle(fontSize: 20);

  List<String> generateAnimeNames() {
    List<String> allAnimeAvailable = [
      "Gintama: THE FINAL",
      "Fruits Basket: The Final",
      "Gintamaº",
      "Kaguya-sama wa Kokurasetai: Ultra Romantic",
      "Hagane no Renkinjutsushi: FULLMETAL ALCHEMIST",
      "Shingeki no Kyojin 3 Part 2",
      "3-gatsu no Lion 2",
      "Owarimonogatari (Ge)",
      "HUNTERxHUNTER (2011)",
      "Steins;Gate",
      "BLEACH: Sennen Kessen-hen",
      "Gintama'",
      "Gintama': Enchousen",
      "Gintama.",
      "Ginga Eiyuu Densetsu",
      "Violet Evergarden Movie",
      "Mob Psycho 100 II",
      "Koe no Katachi",
      "Monogatari Series: Second Season",
      "MONSTER",
      "Kimetsu no Yaiba: Yuukaku-hen",
      "Ashita no Joe 2",
      "Shoujo☆Kageki Revue Starlight Movie",
      "Haikyuu!!: Karasuno Koukou VS Shiratorizawa Gakuen Koukou",
      "Gintama: Kanketsu-hen - Yorozuya yo Eien Nare",
      "Kizumonogatari III: Reiketsu-hen",
      "CLANNAD: After Story",
      "ONE PIECE",
      "Gintama.: Shirogane no Tamashii-hen - Kouhan-sen",
      "Shingeki no Kyojin: The Final Season",
      "Vinland Saga",
      "Shiguang Dailiren",
      "Modao Zushi 3",
      "SPYxFAMILY",
      "Shingeki no Kyojin: The Final Season Part 2",
      "Jujutsu Kaisen",
      "Shouwa Genroku Rakugo Shinjuu: Sukeroku Futatabi-hen",
      "Code Geass: Hangyaku no Lelouch R2",
      "Mushishi Zoku Shou 2",
      "Chainsaw Man",
      "86: Eighty Six Part 2",
      "Mushoku Tensei: Isekai Ittara Honki Dasu Part 2",
      "Kaguya-sama wa Kokurasetai?: Tensaitachi no Renai Zunousen",
      "Fruits Basket: 2nd Season",
      "Haikyuu!! 2nd Season",
      "Odd Taxi",
      "Made in Abyss: Retsujitsu no Ougonkyou",
      "Gintama.: Shirogane no Tamashii-hen",
      "Fate/stay night [Heaven's Feel] III. spring song",
      "Shin Evangelion Movie:||",
      "Hajime no Ippo: THE FIGHTING!",
      "Suzumiya Haruhi no Shoushitsu",
      "Cowboy Bebop",
      "Made in Abyss: Fukaki Tamashii no Reimei",
      "Kimi no Na wa.",
      "Mushishi Zoku Shou",
      "ARIA The ORIGINATION",
      "Cyberpunk: Edgerunners",
      "Sen to Chihiro no Kamikakushi",
      "Jujutsu Kaisen 0",
      "Shingeki no Kyojin 3",
      "Ping Pong THE ANIMATION",
      "Mob Psycho 100 III",
      "Haikyuu!! TO THE TOP 2",
      "Kimetsu no Yaiba: Mugen Ressha-hen",
      "Shin Seiki Evangelion Movie: Air / Magokoro wo, Kimi ni",
      "Tian Guan Ci Fu Special",
      "Made in Abyss",
      "Violet Evergarden",
      "Natsume Yuujinchou Shi",
      "SPYxFAMILY Part 2",
      "Kizumonogatari II: Nekketsu-hen",
      "Natsume Yuujinchou Roku",
      "Fate/Zero 2nd Season",
      "Yojouhan Shinwa Taikei",
      "Hajime no Ippo: New Challenger",
      "Gintama",
      "Mushishi",
      "PERFECT BLUE",
      "Ousama Ranking",
      "Tengen Toppa Gurren Lagann",
      "Chihayafuru 3",
      "NANA",
      "Mononoke-hime",
      "Rurouni Kenshin: Meiji Kenkaku Romantan - Tsuioku-hen",
      "Yuru Camp△ SEASON 2",
      "JoJo no Kimyou na Bouken: Ougon no Kaze",
      "Owarimonogatari",
      "Code Geass: Hangyaku no Lelouch",
      "Howl no Ugoku Shiro",
      "Fate/stay night [Heaven's Feel] II. lost butterfly",
      "JoJo no Kimyou na Bouken: Diamond wa Kudakenai",
      "Shingeki no Kyojin 2",
      "Bocchi the Rock!",
      "Mob Psycho 100",
      "Fruits Basket: prelude",
      "Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season Part 2",
      "Seishun Buta Yarou wa Yumemiru Shoujo no Yume wo Minai",
      "Sora yori mo Tooi Basho"
    ];
    return allAnimeAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 100 AniList Animes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            onPressed: _guide,
            tooltip: 'How to use',
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Watched Anime',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateAnimeNames().take(100));
          }

          final alreadySaved = _watched.contains(_suggestions[index]);

          return ListTile(
            title: Text(
              _suggestions[index],
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_outlined,
              color: alreadySaved
                  ? Color.fromARGB(255, 180, 99, 255)
                  : Color.fromARGB(255, 180, 99, 255),
              semanticLabel: alreadySaved ? 'Remove from watched' : 'Watched',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _watched.remove(_suggestions[index]);
                } else {
                  _watched.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _guide() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('How to use'),
            ),
            body: const Text(
                '1. You can list all your watched anime from top 100 here!\n2. Start by scrolling and recognizing some names\n3. When you find an anime you have watched tap the check box to save it\n4. You can see all your watched anime by clicking on the List icon'),
          );
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _watched.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Watched Animes'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
