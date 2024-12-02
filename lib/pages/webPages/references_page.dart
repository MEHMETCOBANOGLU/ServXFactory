import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ReferencesPage extends StatefulWidget {
  const ReferencesPage({super.key});

  @override
  _ReferencesPageState createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
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
          .loadRequest(Uri.parse("https://www.kspmakine.com/referanslar"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Referanslar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: hasInternet
          ? Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (isLoadingPage)
                  const Center(child: CircularProgressIndicator()),
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
          const Icon(Icons.wifi_off, size: 100, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            "İnternet bağlantısı yok",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _checkInternetConnection(); // Tekrar deneme
            },
            child: const Text("Tekrar Dene"),
          ),
        ],
      ),
    );
  }
}
