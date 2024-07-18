import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HeaderImage extends StatefulWidget {
  final List<dynamic> images;
  final StreamController<int> streamController;

  const HeaderImage({
    super.key,
    required this.images,
    required this.streamController,
  });

  @override
  State<HeaderImage> createState() => HeaderImageState();
}

class HeaderImageState extends State<HeaderImage> {
  late final PageController _pageViewController;

  @override
  void initState() {
    super.initState();

    widget.streamController.sink.add(0);

    _pageViewController = PageController(initialPage: min(0, widget.images.length - 1))
      ..addListener(() {
        widget.streamController.sink.add(_pageViewController.page?.round() ?? 0);
      });
  }

  @override
  void dispose() {
    _pageViewController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return SizedBox(
        height: 260.0,
        child: Image.asset(
          'lib/assets/icons/plot.jpg',
          height: 260.0,
          width: double.infinity,
        ),
      );
    }

    return SizedBox(
      height: 305.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 260.0,
        child: PageView.builder(
          controller: _pageViewController,
          itemCount: widget.images.length,
          itemBuilder: (_, index) {
            final image = widget.images[index];
            bool isVideo = image.contains('.mp4');

            return GestureDetector(
              onTap: () async {},
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 260.0,
                  width: MediaQuery.of(context).size.width,
                  child: isVideo
                      ? VideoPlayerWidget(url: image)
                      : CachedNetworkImage(
                          // cacheKey: imageKey,
                          imageUrl: image,
                          alignment: Alignment.center,
                          memCacheWidth: (MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio).toInt(),
                          fadeInDuration: const Duration(milliseconds: 10),
                          fadeInCurve: Curves.easeIn,
                          errorWidget: (_, __, ___) => Image.asset(
                            'lib/assets/icons/plot.jpg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ),
                          height: 305.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget({required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isError = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          setState(() {});
          _isLoading = false;
        }).catchError((error) {
          setState(() {
            _isLoading = false;
            _isError = true;
          });
          print("Video player initialization error: $error");
        });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      print("Exception: $e");
    }
  }

  void _playPauseVideo() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _isError
            ? Text('Error loading video')
            : _controller != null && _controller!.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                      if (!_controller!.value.isPlaying)
                        IconButton(
                          iconSize: 64.0,
                          icon: Icon(Icons.play_circle_outline, color: Colors.white),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenVideoPlayerScreen(videoUrl: widget.url),
                            ),
                          ),
                        ),
                    ],
                  )
                : Text('Error initializing video player');
  }
}

class FullScreenVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _FullScreenVideoPlayerScreenState createState() => _FullScreenVideoPlayerScreenState();
}

class _FullScreenVideoPlayerScreenState extends State<FullScreenVideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller?.play();
        });
      }).catchError((error) {
        print("Error initializing video player: $error");
        setState(() {
          _isLoading = false;
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : Text('Error initializing video player', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: _controller != null && _controller!.value.isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying ? _controller?.pause() : _controller?.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
