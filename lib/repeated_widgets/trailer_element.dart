import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailer extends StatefulWidget {

  var ytTrailerId;

  WatchTrailer(this.ytTrailerId);

  @override
  State<WatchTrailer> createState() => _WatchTrailerState();
}

class _WatchTrailerState extends State<WatchTrailer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoid = YoutubePlayer.convertUrlToId(widget.ytTrailerId);
    _controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags: YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
        mute: false,
        // controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  } // sarbagyastha.com.np (2024) Youtube_player_flutter, pub.dev. Available at: https://pub.dev/packages/youtube_player_flutter.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: YoutubePlayer(
        thumbnail: Image.network(
          "https://img.youtube.com/vi/" + widget.ytTrailerId + "/hqdefault.jpg",
          fit: BoxFit.cover,
        ),
        controlsTimeOut: Duration(milliseconds: 1500),
        aspectRatio: 16 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        bufferIndicator: const Center(
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          )),
        ),
        
        progressIndicatorColor: Colors.amber,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.white,
                handleColor: Colors.amber,
              )),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}