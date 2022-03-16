import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatefulWidget {
  GifPage(this.gifData, {Key? key}) : super(key: key);

  Map gifData;

  @override
  _GifPageState createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Share.share(widget.gifData["images"]["fixed_height"]["url"]);
              },
              icon: const Icon(Icons.share))
        ],
        title: Text(widget.gifData["title"]),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(widget.gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
