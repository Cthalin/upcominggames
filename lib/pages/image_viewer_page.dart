import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

@RoutePage()
class ImageViewerPage extends StatelessWidget {
  final String image;

  const ImageViewerPage({required this.image}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: "screenshot",
        child: PhotoView(
          imageProvider: NetworkImage(image),
          backgroundDecoration: const BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
