import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';

class ListHorizontal extends StatefulWidget {
  final double fix;
  final String title;
  final String description;
  final String imageUrl;
  ListHorizontal({
    Key key,
    this.title,
    this.description,
    this.imageUrl,
    this.fix,
  });

  @override
  _ListHorizontalState createState() => _ListHorizontalState();
}

class _ListHorizontalState extends State<ListHorizontal> {
  static const String placeholderImg = 'assets/noImage.png';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24 * widget.fix),
              baseText(
                  text: utf8.decode(widget.title.runes.toList()),
                  fontWeight: FontWeight.bold),
              SizedBox(height: 36 * widget.fix),
              CachedNetworkImage(
                placeholder: (context, url) => Image.asset(placeholderImg),
                imageUrl: widget.imageUrl,
                height: MediaQuery.of(context).size.height * 0.4 * widget.fix,
                width: MediaQuery.of(context).size.width * 0.8 * widget.fix,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 36 * widget.fix),
              baseText(text: widget.description, maxLines: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget baseText(
      {String text,
      double sizeText = 18,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      int maxLines = 1}) {
    return GestureDetector(
      child: Text(
        "$text",
        style: TextStyle(
          color: color,
          fontSize: sizeText,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
