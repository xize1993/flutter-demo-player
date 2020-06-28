import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_player_demo/common/song_scanner.dart';
import 'package:flutter_player_demo/component/bottom_player_bar.dart';
import 'package:flutter_player_demo/page/track_list_dialog.dart';

class HomePageWidget extends StatefulWidget {

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePageWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  AssetsAudioPlayer _player;
  final _tabs = ["单曲", "专辑"];
  final _trackListDialogStateKey = GlobalKey<TrackListDialogState>();
  final _bottomPlayerBarStateKey = GlobalKey<BottomPlayerBarState>();

  // Get Method
  GlobalKey<TrackListDialogState> get trackListDialogStateKey => _trackListDialogStateKey;
  GlobalKey<BottomPlayerBarState> get bottomPlayerBarStateKey => _bottomPlayerBarStateKey;
  AssetsAudioPlayer get player => _player;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _player = AssetsAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    return Scaffold(
        backgroundColor: _themeData.backgroundColor,
        appBar: AppBar(
          title: Text("FlutterPlayer"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.sync),
                onPressed: () async {
                  var trackList = await _getAudios();
                  await _player.open(Playlist(audios: trackList), autoStart: false);
                  _trackListDialogStateKey.currentState.setState(() {});
                }),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          TrackListDialog(key: _trackListDialogStateKey),
          Row(children: [Text("专辑")])
        ]),
        bottomNavigationBar: BottomPlayerBar(key: _bottomPlayerBarStateKey)
        );
  }



  Future<List<Audio>> _getAudios() async {
    var list = await getExternalStorageDirectories();
    return SongScanner.getAudio(list[0]);
  }
}
