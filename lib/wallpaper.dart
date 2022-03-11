import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullScreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({Key key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=30'),
        headers: {
          'Authorization':
              '563492ad6f9170000100000155214ccc87b54efb8e16b0d7c980bc66'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=30&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f9170000100000155214ccc87b54efb8e16b0d7c980bc66'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                        child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              imageUrl: images[index]['src']['large2x'],
                            ),
                          ));
                    },
                    child: Container(
                      color: Colors.amber,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
                      )),
          SafeArea(
            child: InkWell(
              onTap: loadMore,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                    child: Text(
                  'Load More',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
