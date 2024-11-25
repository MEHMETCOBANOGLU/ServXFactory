import 'package:flutter/material.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:video_player/video_player.dart';

class IntroVideoPage extends StatefulWidget {
  const IntroVideoPage({super.key});

  @override
  State<IntroVideoPage> createState() => _IntroVideoPageState();
}

class _IntroVideoPageState extends State<IntroVideoPage> {
  late VideoPlayerController _controller;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    // Video dosyasını başlat
    _controller = VideoPlayerController.asset("assets/videos/ksptanitim.mp4")
      ..initialize().then((_) {
        setState(() {}); // Video yüklendiğinde UI'yi güncelle
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isVideoPlaying = false;
      } else {
        _controller.play();
        _isVideoPlaying = true;
      }
    });
  }

  void _stopVideo() {
    setState(() {
      _controller.pause();
      _isVideoPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text("Tanıtım Video", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video veya resim gösterimi
            if (_isVideoPlaying && _controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            else
              Image.asset(
                "assets/images/fature-videos.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),

            // Oynatma simgesi, video oynarken gizlenir
            if (!_isVideoPlaying)
              Positioned(
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 60.0,
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),

            // Çarpı (Kapat) simgesi, video oynarken görünür
            if (_isVideoPlaying)
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: _stopVideo,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
