import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player_demo/page/homepage.dart';


class BottomPlayerBar extends StatefulWidget {

  BottomPlayerBar({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new BottomPlayerBarState();
  }
}

class BottomPlayerBarState extends State<BottomPlayerBar> {

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    HomePageState _homePageState = context.findAncestorStateOfType();
    final _player = _homePageState.player;

    return _player.current.value == null ? Container(height:0.0, width:0.0) :
      Container(
      height: 56.0,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(color: _themeData.primaryColor),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image(
                image: Image.asset("assets/record.png").image,
                width: 50.0,
                height: 50.0
              )
            ),
          ),
          Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _player.current.value.audio.audio.metas.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    PlayerBuilder.currentPosition(
                      player: _player,
                      builder: (context, duration) {
                        return Text(
                          '${_formatDuration(duration)}/${_formatDuration(_player.current.value.audio.duration)}',
                          style: TextStyle(color: Colors.black54)
                        );
                      }
                    ),
                  ],
                ),
              )),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(
                _player.isPlaying.value ? Icons.pause : Icons.play_arrow,
              ),
            ),
            onTap: () async{
              await _player.playOrPause();
              _homePageState.setState(() {});
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    var minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    var seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

}