import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_player_demo/model/song.dart';
import 'package:path/path.dart' as path;


class SongScanner {

  static List<Song> getSongs(Directory directory) {
    List<FileSystemEntity> listFileEntity = directory.listSync();
    var list = listFileEntity
        .where((element) => element.path.endsWith(".mp3"))
        .map((e) => Song.fromFile(new File(e.path)))
        .toList();
    return list;
  }

  static List<Audio> getAudio(Directory directory) {
    List<FileSystemEntity> listFileEntity = directory.listSync();
    var list = listFileEntity
        .where((element) => element.path.endsWith(".mp3"))
        .map((e) => Audio.file(e.path,
          metas: Metas(
              title: path.basename(e.path),
              artist: "artist",
              album: "album",
          )))
        .toList();
    return list;
  }

}
