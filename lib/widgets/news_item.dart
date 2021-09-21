import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  NewItem({
    Key key,
    this.title,
    this.description,
    this.imageUrl,
  });

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  static const String placeholderImg = 'images/no_image.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("data"),
        // CachedNetworkImage(
        //   placeholder: (context, url) => Image.asset(placeholderImg),
        //   imageUrl:
        //       "https://i1-dulich.vnecdn.net/2021/09/15/img3545-1631690263-1631690279-8527-1631690450.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=nbSXwrnpORnaORpjS0PfJQ",
        //   height: 50,
        //   width: 70,
        //   alignment: Alignment.center,
        //   fit: BoxFit.fill,
        // ),
        Text("data"),
      ],
    );
  }
}
