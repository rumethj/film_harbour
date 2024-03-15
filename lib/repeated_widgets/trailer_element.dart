import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailer extends StatefulWidget {

  final String ytTrailerId;

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
  } // (niranjandahal. 2024)

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
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(227, 45, 86, 1)),
          )),
        ),
        
        progressIndicatorColor: Colors.amber,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.white,
                handleColor: CustomTheme.mainPalletRed,
              )),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}