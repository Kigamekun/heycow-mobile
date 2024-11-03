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
     ..loadRequest(Uri.parse("https://heycow.my.id/api/transactions/create-charge"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Midtrans Payment'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
