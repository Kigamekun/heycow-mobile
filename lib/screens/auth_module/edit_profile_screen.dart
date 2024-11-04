import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  
  File? _selectedImage;

  // Helper to pick date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // selectedDate = picked;
      });
    }
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to submit form data along with image
  Future<void> _submitForm() async {
    
    if (_formKey.currentState!.validate()) {
      // final formData = dio.FormData.fromMap({
      //   "nama": "Mulyadi", // Add other form fields here
      //   "email": "mulyadi@ymail.com",
      //   "phone_number": "+1 234-567-890",
      //   "farm_name": "Mulyadi Farm",
      //   "profile_picture": _selectedImage != null
      //       ? await dio.MultipartFile.fromFile(_selectedImage!.path,
      //           filename: _selectedImage!.path.split('/').last)
      //       : null,
      // });

      try {
        final dio = Dio();
        final response = await dio.post(
          'https://your-api-url.com/updateProfile', // Ganti dengan URL API Anda
          data: {
            "nama": "Mulyadi", // Add other form fields here
            "email": "",
            "phone_number": "+1 234-567-890",
            "farm_name": "Mulyadi Farm",
            "profile_picture": _selectedImage != null
                ? null
                : null,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated: ${response.data}')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }
   final AuthController _authController = Get.find<AuthController>();


  @override
  void initState() {
    super.initState();
    _authController.getUser(); // Call the getUserData method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Edit Profile',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A577),
                Color(0xFF64CFAA),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEBED),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33959DA5),
                                  blurRadius: 24,
                                  offset: Offset(0, 8),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: _selectedImage != null
                                            ? FileImage(_selectedImage!)
                                            : const AssetImage(
                                                'assets/pp.png',
                                              ) as ImageProvider,
                                      ),
                                      const SizedBox(height: 10),
                                      TextButton(
                                        onPressed: _pickImage,
                                        child: const Text(
                                          'Edit Profile Picture',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                _buildTextField(
                                    label: 'Nama',
                                    initialValue: _authController.nama.value),
                                const SizedBox(height: 20),
                                _buildTextField(
                                    label: 'Email',
                                    initialValue: _authController.email.value),
                                const SizedBox(height: 20),
                                _buildTextField(
                                    label: 'Phone Number',
                                    initialValue: _authController.phone.value),
                                const SizedBox(height: 20),
                                _buildTextField(
                                    label: 'Farm Name',
                                    initialValue: _authController.farmName.value),
                                const SizedBox(height: 40),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF20A577),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

// AlertBox widget
class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: const Row(
        children: [
          Icon(Icons.info, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text('Ada bagian form yang tidak terisi')),
        ],
      ),
    );
  }
}

// GenderButton widget
class GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  // Custom TextField Widget for consistent design
}

Widget _buildTextField({required String label, required String initialValue}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}
