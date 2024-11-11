import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/contract_module/contract_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapScreen extends StatefulWidget {
  final int id;

  const SnapScreen({super.key, required this.id});

  @override
  State<SnapScreen> createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {
  late WebViewController controller;
  String? snapToken;
  bool isLoading = true; // For loading indicator

  bool isPayed = false;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
    // getSnapToken(); // Fetch the Snap token
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading = false;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
                  .startsWith('https://heycow.my.id/pay-api-finish') ||
              request.url.startsWith('https://heycow.my.id/history') ||
              request.url.startsWith('https://heycow.my.id/login')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ContractScreen()),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
     ..loadRequest(Uri.parse('https://heycow.my.id/transactions/create-charge/${widget.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set tombol back menjadi putih
        ),
        title: const Text('Contract Payment',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577), // Start color
                Color(0xFF64CFAA), // End color
              ],
            ),
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
