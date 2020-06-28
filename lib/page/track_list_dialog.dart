import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player_demo/component/song_line_view.dart';

import 'homepage.dart';

class TrackListDialog extends StatefulWidget {
  TrackListDialog({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new TrackListDialogState();
}

class TrackListDialogState extends State<TrackListDialog> {

  @override
  Widget build(BuildContext context) {
    HomePageState _homePageState = context.findAncestorStateOfType();
    final player = _homePageState.player;
    return ListView(children: createSongs(player.playlist?.audios));
  }

}

List<SongLineView> createSongs(List<Audio> listSong) {
  var list = new List<SongLineView>();
  if (listSong != null) {
    listSong.forEach((element) {
      list.add(
          new SongLineView(audio: element, index: listSong.indexOf(element)));
    });
  }
  return list;
}
