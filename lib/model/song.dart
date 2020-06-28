import 'dart:io';
import 'package:path/path.dart' as path;

class Song {

  final int id;

  final String title;

  final String album;

  final String author;

  final String url;

  final DateTime time;

  const Song({this.id, this.title, this.album, this.author, this.url, this.time}) : super();

  static Song fromFile(File file) {
    print(file.path);
    return new Song(
      id : 1,
      title : path.basename(file.path),
      album: "album",
      author: "",
      url: file.path.toString(),
      time: DateTime.now()
    );
  }

}
