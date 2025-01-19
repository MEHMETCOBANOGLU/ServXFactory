import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediaCenterPage extends StatefulWidget {
  const MediaCenterPage({super.key});

  @override
  _MediaCenterPageState createState() => _MediaCenterPageState();
}

class _MediaCenterPageState extends State<MediaCenterPage> {
  late final WebViewController _controller1;
  late final WebViewController _controller2;
  bool isLoadingPage1 = true;
  bool isLoadingPage2 = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controller1 = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoadingPage1 = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoadingPage1 = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.kspmakine.com/foto-galeri"));

    _controller2 = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoadingPage2 = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoadingPage2 = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.kspmakine.com/video-galeri"));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Tab sayısı
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Medya Merkezi",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tooltip(
                message: "Foto Galeri",
                child: Tab(
                  icon: Icon(Icons.home),
                  text: "Foto Galeri",
                ),
              ),
              Tooltip(
                message: "Video Galeri",
                child: Tab(
                  icon: Icon(Icons.info),
                  text: "Video Galeri",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(_controller1, isLoadingPage1),
            _buildTabContent(_controller2, isLoadingPage2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(WebViewController controller, bool isLoading) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
