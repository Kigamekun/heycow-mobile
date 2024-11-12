// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/main_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class CommunityCreateScreen extends StatefulWidget {

  const CommunityCreateScreen({super.key});

  @override
  _CommunityCreateScreenState createState() =>
      _CommunityCreateScreenState();
}

class _CommunityCreateScreenState extends State<CommunityCreateScreen> {
  // Controllers for each TextField
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  File? _selectedImage;
  final picker = ImagePicker();
  final dio.Dio _dio = dio.Dio();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _titleController.dispose();
    _priceController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select an image')));
      return;
    }

    try {
      final formData = dio.FormData.fromMap({
        "title": _titleController.text,
        "category": "forum",
        "content": _contentController.text,
        "image": await dio.MultipartFile.fromFile(_selectedImage!.path,
            filename: "image.jpg"),
      });

      final response = await _dio.post(
        'https://heycow.my.id/api/blog-posts',
        data: formData,
        options: dio.Options(
          headers: {
            "Authorization": 'Bearer ${_authController.accessToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully')));
        // Redirect to MainScreen with CommunityScreen as the selected tab
        Get.offAll(() => const MainScreen(initialIndex: 3));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to submit form')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Jual Sapi',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF20A577), Color(0xFF64CFAA)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CustomFormField(
                label: 'Judul',
                isRequired: true,
                hintText: 'Masukkan Judul',
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              CustomFormField(
                label: 'Notes',
                hintText: '',
                maxLines: 3,
                controller: _contentController,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.image, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        _selectedImage == null
                            ? 'Select an Image'
                            : 'Image Selected',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              if (_selectedImage != null)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String hintText;
  final Icon? suffixIcon;
  final int maxLines;
  final TextEditingController controller;

  const CustomFormField({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            children: isRequired
                ? [
                    const TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
