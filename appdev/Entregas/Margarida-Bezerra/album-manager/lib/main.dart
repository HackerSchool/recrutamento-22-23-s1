import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(App_Splashscreen());

class App_Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: Splashscreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                width: 400,
                height: 400,
                color: Colors.white,
                child: Align(
                    child: Stack(children: [
                  Text(
                    "Welcome to Album Manager app \n ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 44, color: Colors.black.withOpacity(0.8)),
                  ),
                  Align(
                      child: Icon(Icons.audiotrack,
                          color: Colors.blue, size: 70.0),
                      alignment: Alignment.center)
                ])))));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple), home: FavouriteAlbums());
  }
}

class FavouriteAlbums extends StatefulWidget {
  @override
  FavouriteAlbumsState createState() => FavouriteAlbumsState();
}

class FavouriteAlbumsState extends State<FavouriteAlbums> {
  final favAlbumLinks = <String>[];
  final allAlbumLinks = <String>[
    "https://media.pitchfork.com/photos/5d2750847953c00009b978cb/1:1/w_600/Clairo_Immunity.jpg",
    "https://media.pitchfork.com/photos/5cace177f06ec513acac0345/1:1/w_320,c_limit/VampireWeekend_FatherOfTheBride.jpg",
    "https://media.pitchfork.com/photos/5929b2fe9d034d5c69bf4c59/1:1/w_320,c_limit/7055fb4d.jpg",
    "https://media.pitchfork.com/photos/5ee923f47bb7acb328d5683d/1:1/w_320,c_limit/Punisher%20_Phoebe%20Bridgers.jpg",
    "https://media.pitchfork.com/photos/63061cdbc3194266963384da/1:1/w_320,c_limit/Arctic-Monkeys-The-Car.jpg",
    "https://media.pitchfork.com/photos/595509cab91767379d2a6fa2/1:1/w_320,c_limit/600x600bb-6.jpg",
    "https://media.pitchfork.com/photos/5a6bbac13420733373a631ec/1:1/w_320,c_limit/fleetwoodmac.jpg",
    "https://media.pitchfork.com/photos/5bbe2ef2b467a1075a1ba022/1:1/w_320,c_limit/greta%20van%20fleet_peaceful%20army.jpg",
    "https://media.pitchfork.com/photos/600741a2b8ed6615167dc583/1:1/w_320,c_limit/Ashnikko%20-%20Demidevil.jpg",
    "https://media.pitchfork.com/photos/5929aed09d034d5c69bf45f4/1:1/w_320,c_limit/9c17ddf5.jpg",
    "https://media.pitchfork.com/photos/63495dffa7846fb4be7fe006/1:1/w_320,c_limit/Taylor-Swift-Midnights.jpg",
    "https://media.pitchfork.com/photos/5e94b867b09a5100092ba764/1:1/w_320,c_limit/SAWAYAMA_Rina%20Sawayama.jpg",
    "https://media.pitchfork.com/photos/5ac23ab298b8787dde3c7669/1:1/w_320,c_limit/Tom%20Misch:%20Geography.jpg",
    "https://media.pitchfork.com/photos/613fd9c22254f3e4030e4dd1/1:1/w_320,c_limit/100000x100000-999.jpeg",
    "https://media.pitchfork.com/photos/5929af919d034d5c69bf472c/1:1/w_320,c_limit/8ba5c502.jpg",
    "https://media.pitchfork.com/photos/5e8ca8479a08f300084d48d7/1:1/w_320,c_limit/The%20New%20Abnormal_The%20Strokes.jpg",
    "https://media.pitchfork.com/photos/59ea85d552f4e263cfef8273/1:1/w_320,c_limit/thequeenisdead.jpg",
    "https://media.pitchfork.com/photos/5929a5f0ea9e61561daa525d/1:1/w_320,c_limit/f43e31e0.jpg",
    "https://media.pitchfork.com/photos/5e3c40a120256b00096b9f8c/1:1/w_320,c_limit/Green-Day.jpg",
    "https://media.pitchfork.com/photos/623b686c6597466fa9d6e32d/1:1/w_320,c_limit/Harry-Styles-Harrys-House.jpeg"
  ];

  Widget buildAlbumSquareWidgetNoHeart(String imageURL) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Image(
        image: NetworkImage(imageURL),
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget buildAlbumSquareWidget(String imageURL) {
    final favourite = favAlbumLinks.contains(imageURL);
    return Stack(children: [
      buildAlbumSquareWidgetNoHeart(imageURL),
      Align(
          alignment: Alignment(0.8, 0.8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (favourite) {
                  favAlbumLinks.remove(imageURL);
                } else {
                  favAlbumLinks.insert(0, imageURL);
                }
              });
            },
            child: Container(
                child: Icon(favourite ? Icons.favorite : Icons.favorite,
                    color: favourite ? Colors.red : Colors.grey)),
          ))
    ]);
  }

  Widget _buildAlbumsList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: allAlbumLinks.length,
        itemBuilder: (BuildContext context, int index) {
          return buildAlbumSquareWidget(allAlbumLinks[index]);
        });
  }

  Widget _buildFavAlbumsList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: favAlbumLinks.length,
        itemBuilder: (BuildContext context, int index) {
          return buildAlbumSquareWidgetNoHeart(favAlbumLinks[index]);
        });
  }

  void pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: build_favs_page));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Albums"), actions: <Widget>[
        IconButton(onPressed: pushSaved, icon: Icon(Icons.favorite))
      ]),
      body: _buildAlbumsList(),
      backgroundColor: Colors.blueGrey[900],
    );
  }

  Widget build_favs_page(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourite Albums"), actions: <Widget>[
        IconButton(onPressed: pushSaved, icon: Icon(Icons.list))
      ]),
      body: _buildFavAlbumsList(),
      backgroundColor: Colors.blueGrey[900],
    );
  }
}
