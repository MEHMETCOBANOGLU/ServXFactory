import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoadingPage = true;
  late final WebViewController _controller;
  bool hasInternet = true; // İnternet durumu

  @override
  void initState() {
    super.initState();
    _checkInternetConnection(); // Uygulama başladığında internet kontrolü
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoadingPage = false;
            });
          },
        ),
      );
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false; // İnternet bağlantısı yok
      });
    } else {
      setState(() {
        hasInternet = true; // İnternet bağlantısı var
      });
      _controller
          .loadRequest(Uri.parse("https://www.kspmakine.com/hakkimizda"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Hakkımızda",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: hasInternet
          ? Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (isLoadingPage) Center(child: CircularProgressIndicator()),
              ],
            )
          : _noInternetWidget(), // İnternet yoksa özel bir widget göster
    );
  }

  Widget _noInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 100, color: Colors.red),
          SizedBox(height: 16),
          Text(
            "İnternet bağlantısı yok",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _checkInternetConnection(); // Tekrar deneme
            },
            child: Text("Tekrar Dene"),
          ),
        ],
      ),
    );
  }
}
