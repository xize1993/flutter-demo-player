import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player_demo/page/homepage.dart';

class SongLineView extends StatefulWidget {
  SongLineView({Key key, @required this.audio, @required this.index}) : super(key: key);

  final Audio audio;
  final int index;

  @override
  State<StatefulWidget> createState() => new _SongLineViewState(audio, index);
}

class _SongLineViewState extends State<SongLineView> {
  _SongLineViewState(this._audio, this._index);

  final Audio _audio;
  final int _index;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    HomePageState _homePageState = context.findAncestorStateOfType();
    final _player = _homePageState.player;

    bool _isCurrentPlayIndex() {
      return _player.current.value.index == _index;
    }

    return Row(
      children: [
        Expanded(
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            height: 55,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _audio.metas.title.replaceAll(".mp3", ""),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: _isCurrentPlayIndex()
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _isCurrentPlayIndex()
                        ? _themeData.primaryColor
                        : Colors.black),
              ),
              Text(
                "${_audio.metas.artist} - ${_audio.metas.album}",
                style: TextStyle(
                    fontSize: 14,
                    color: _isCurrentPlayIndex()
                        ? _themeData.primaryColor
                        : Colors.grey),
              ),
            ],
          ),
        )),
        InkWell(
          borderRadius: new BorderRadius.circular(25.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Icon(
              _player.isPlaying.value && _isCurrentPlayIndex() ? Icons.pause : Icons.play_arrow,
              size: 20.0,
              color: Colors.grey,
            ),
          ),
          onTap: () async {
            if (!_isCurrentPlayIndex()) {
              await _player.playlistPlayAtIndex(_index);
              _homePageState.trackListDialogStateKey.currentState.setState(() { });
            } else {
              await _player.playOrPause();
              setState(() {});
            }
            _homePageState.bottomPlayerBarStateKey.currentState.setState(() { });
          },
        ),
      ],
    );
  }
}
