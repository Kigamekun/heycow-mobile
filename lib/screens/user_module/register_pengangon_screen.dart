import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';

class RegisterPengangonScreen extends StatefulWidget {
  const RegisterPengangonScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPengangonScreenState createState() =>
      _RegisterPengangonScreenState();
}

class _RegisterPengangonScreenState extends State<RegisterPengangonScreen> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _upahController = TextEditingController();
  File? _foto;
  File? _fotoKtp;
  final ImagePicker _picker = ImagePicker();
  final dio.Dio _dio = dio.Dio();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _nikController.dispose();
    _upahController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, bool isKtp) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isKtp) {
          _fotoKtp = File(pickedFile.path);
        } else {
          _foto = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_foto == null || _fotoKtp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both photos')),
      );
      return;
    }

    var formData = dio.FormData.fromMap({
      "selfie_ktp":
          await dio.MultipartFile.fromFile(_foto!.path, filename: 'foto.jpeg'),
      "ktp": await dio.MultipartFile.fromFile(_fotoKtp!.path,
          filename: 'fotoKtp.jpeg'),
      'nik': _nikController.text,
      'upah': _upahController.text,
    });

    try {
      final response = await _dio.post(
        'https://heycow.my.id/api/users/submit-request-form',
        data: formData,
        options: dio.Options(
          headers: {
            "Authorization": 'Bearer ${_authController.accessToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Pengangon registered successfully: ${response.data}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusMessage}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Register Pengangon',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
              label: 'NIK',
              isRequired: true,
              hintText: 'Masukkan NIK',
              controller: _nikController,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery, false),
              child: _buildImagePicker('Foto', _foto),
            ),
            if (_foto != null) _buildImagePreview(_foto!),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery, true),
              child: _buildImagePicker('Foto KTP', _fotoKtp),
            ),
            if (_fotoKtp != null) _buildImagePreview(_fotoKtp!),
            const SizedBox(height: 16),
            CustomFormField(
              label: 'Upah',
              isRequired: true,
              hintText: 'Masukkan Upah',
              controller: _upahController,
              suffixIcon: const Icon(Icons.money),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
    );
  }

  Widget _buildImagePicker(String label, File? imageFile) {
    return Container(
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
            imageFile == null ? 'Select $label' : '$label Selected',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(File imageFile) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
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
  final TextEditingController controller;

  const CustomFormField({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.hintText,
    this.suffixIcon,
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
