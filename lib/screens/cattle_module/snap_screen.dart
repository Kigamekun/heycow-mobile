import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SnapScreen extends StatefulWidget {
  const SnapScreen({Key? key}) : super(key: key);

  @override
  State<SnapScreen> createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {
  late WebViewController controller;
  String? snapToken;
  bool isLoading = true; // For loading indicator

  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
    // getSnapToken(); // Fetch the Snap token
     ..loadRequest(Uri.parse("https://heycow.my.id/transactions/create-charge"));
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
