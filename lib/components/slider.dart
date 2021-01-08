import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:meyirim/globals.dart' as globals;

class SliderWidget extends StatefulWidget {
  final List photos;
  final String videoUrl;

  const SliderWidget({Key key, this.photos, this.videoUrl}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

// ignore: must_be_immutable
class _SliderState extends State<SliderWidget> {
  int _sliderLength = 0;
  int _current = 0;
  // ignore: close_sinks
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _sliderLength = widget.photos.length;
    if (widget.videoUrl != null && widget.videoUrl.isNotEmpty) {
      // ignore: close_sinks
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoUrl,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
      _sliderLength = _sliderLength + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_sliderLength != null && _sliderLength > 0)
          Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  child: CarouselSlider.builder(
                    itemCount: _sliderLength,
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        aspectRatio: 4 / 3,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    itemBuilder: (context, index) {
                      if (widget.photos.asMap().containsKey(index)) {
                        return Container(
                            child: Hero(
                          tag: widget.photos[index].path,
                          child: CachedNetworkImage(
                            imageUrl: widget.photos[0].path,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ));
                      } else {
                        return Container(
                          child: YoutubePlayerIFrame(
                            controller: _controller,
                            aspectRatio: 16 / 9,
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (_sliderLength != null && _sliderLength > 1)
                  Positioned(
                    child: Container(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List<int>.generate(_sliderLength, (i) => i)
                            .map((index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? HexColor('#00D7FF')
                                  : Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ])
        else
          Image.network(globals.dummyPhoto),
        //ProjectStatus(project: project, full: true)
      ],
    );
  }
}
