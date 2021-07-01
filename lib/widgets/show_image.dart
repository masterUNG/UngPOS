import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String pathImage;
  const ShowImage({Key? key, required this.pathImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(pathImage);
  }
}
