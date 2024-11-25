import 'package:flutter/material.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final WebViewController _controller1;
  late final WebViewController _controller2;
  late final WebViewController _controller3;
  bool isLoadingPage1 = true;
  bool isLoadingPage2 = true;
  bool isLoadingPage3 = true;

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
      ..loadRequest(Uri.parse(
          "https://www.kspmakine.com/urunler-endustriyel-parca-yikama-makineleri-1"));

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
      ..loadRequest(
          Uri.parse("https://www.kspmakine.com/urunler-taslama-makineleri-2"));

    _controller3 = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoadingPage3 = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoadingPage3 = false;
            });
          },
        ),
      )
      ..loadRequest(
          Uri.parse("https://www.kspmakine.com/urunler-test-ekipmanlari-3"));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Tab sayısı
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            "Ürünler",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Tooltip(
                message: "Endüstriyel Parça Yıkama",
                child: Tab(
                  icon: Icon(Icons.home),
                  text: "Endüstriyel Parça Yıkama",
                ),
              ),
              Tooltip(
                message: "Taşlama Makineleri",
                child: Tab(
                  icon: Icon(Icons.info),
                  text: "Taşlama Makineleri",
                ),
              ),
              Tooltip(
                message: "Test Ekipmanları",
                child: Tab(
                  icon: Icon(Icons.info),
                  text: "Test Ekipmanları",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(_controller1, isLoadingPage1),
            _buildTabContent(_controller2, isLoadingPage2),
            _buildTabContent(_controller3, isLoadingPage3),
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
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
