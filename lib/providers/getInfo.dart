import 'dart:convert' show utf8;

class GetInfo {
  String getImage({String description, String link}) {
    description.toString().replaceAll("$link", "").trim();

    if (description.indexOf('src="') == -1 &&
        description.indexOf('" ></a></br>') == -1) {
      return "";
    } else
      return description
          .substring(
              description.indexOf('src="'), description.indexOf('" ></a></br>'))
          .replaceAll('src="', "");
  }

  String getDescription({String description, String link}) {
    return utf8.decode(description
        .replaceAll(link, "")
        .replaceAll(getImage(description: description, link: link), "")
        .replaceAll('<a href=""><img src="" ></a></br>', '')
        .runes
        .toList());
  }
}
