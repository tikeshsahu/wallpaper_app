import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({Key key,  this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  // Future<void> setWallpaper() async {
  //   int location = WallpaperManager.HOME_SCREEN;
  //   var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
  //   String result =
  //       await WallpaperManager.setWallpaperFromFile(file.path, location);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: Image.network(widget.imageUrl, fit: BoxFit.cover),
              )),
              SafeArea(
                child: InkWell(
                  //onTap: setWallpaper,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                        child: Text(
                      'Set as Wallpaper',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
