import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';

class ListVertical extends StatefulWidget {
  final double fix;
  final String title;
  final String description;
  final String imageUrl;
  ListVertical({
    Key key,
    this.title,
    this.description,
    this.imageUrl,
    this.fix,
  });

  @override
  _ListVerticalState createState() => _ListVerticalState();
}

class _ListVerticalState extends State<ListVertical> {
  static const String placeholderImg = 'assets/noImage.png';
  @override
  Widget build(BuildContext context) {
    // return ListTile(
    // leading: CachedNetworkImage(
    //   placeholder: (context, url) => Image.asset(placeholderImg),
    //   imageUrl: widget.imageUrl,
    //   height: MediaQuery.of(context).size.height * 0.4,
    //   width: MediaQuery.of(context).size.width * 0.22,
    //   alignment: Alignment.center,
    //   fit: BoxFit.fill,
    //   ),
    //   title: baseText(
    //       text: utf8.decode(widget.title.runes.toList()),
    //       fontWeight: FontWeight.bold),
    //   subtitle: baseText(text: widget.description, maxLines: 3),
    // );
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Image.asset(placeholderImg),
            imageUrl: widget.imageUrl,
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.22,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                baseText(
                    text: utf8.decode(widget.title.runes.toList()),
                    fontWeight: FontWeight.bold),
                baseText(text: widget.description, maxLines: 3),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget baseText(
      {String text,
      double sizeText = 18,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      int maxLines = 2}) {
    return GestureDetector(
      child: Text(
        "$text",
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: sizeText,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
