import 'dart:convert';

import 'package:conversormoedas/Apps/gifs/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeGifs extends StatefulWidget {
  const HomeGifs({Key? key}) : super(key: key);

  @override
  _HomeGifsState createState() => _HomeGifsState();
}

class _HomeGifsState extends State<HomeGifs> {
  String? _search;

  int _offset = 0;

  int _limit = 19;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=mdQqIH1vjxn5CxG3EAkgbtJAe57m7oVO&limit=19&rating=g"));
    } else {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=mdQqIH1vjxn5CxG3EAkgbtJAe57m7oVO&q=$_search&limit=$_limit&offset=$_offset&rating=g&lang=en"));
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _getGifs().then((map) => {print(map)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: "Pesquise Aqui",
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            onSubmitted: (text) {
              setState(() {
                _search = text;
                _offset = 0;
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _getGifs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Container();
                  } else {
                    return _createGiftTable(context, snapshot);
                  }
              }
            },
          ),
        ),
      ],
    );
  }

  int _getCount(List data) {
    if (_search == null || _search!.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  _createGiftTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data!["data"].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data!["data"][index]["images"]["fixed_height"]
                  ["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GifPage(snapshot.data!["data"][index])));
            },
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"]);
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                children: const [
                  Icon(Icons.add, color: Colors.white, size: 70)
                ],
              ),
              onTap: () {
                setState(() {
                  // _offset += 19;
                  _limit = _limit + 19;
                });
              },
            ),
          );
        }
      },
    );
  }
}
