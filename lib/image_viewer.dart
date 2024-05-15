import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String image = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Hero(
              tag: "screenshot",
              child: PhotoView(
                imageProvider: NetworkImage(image),
                backgroundDecoration: BoxDecoration(color: Colors.white),
              )),
        ));
  }
}
