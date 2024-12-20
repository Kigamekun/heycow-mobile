// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
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

  final dio.Dio _dio = dio.Dio(); // Use 'dio.Dio' with alias

  File? _selectedImage;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _farmNameController;
  late TextEditingController _farmAddressController;
  late TextEditingController _upahController;

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
      // Create FormData with user details and image file
      final formData = dio.FormData.fromMap({
        "nama": _nameController.text,
        "email": _emailController.text,
        "phone_number": _phoneController.text,
        "address": _addressController.text,
        "farm_name": _farmNameController.text,
        "farm_address": _farmAddressController.text,
        "upah": _upahController.text,
        "avatar": _selectedImage != null
            ? await dio.MultipartFile.fromFile(_selectedImage!.path,
                filename: _selectedImage!.path.split('/').last)
            : null,
      });

      try {
        // Define the API endpoint
        const String apiUrl = "https://heycow.my.id/api/update-profile";

        // Send the formData to the server
        final response = await _dio.post(
          apiUrl,
          data: formData,
          options: dio.Options(
            headers: {
              "Authorization": 'Bearer ${_authController.accessToken}',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Handle success response
          _authController.getUser(); // Call the getUserData method

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          // Handle unsuccessful response
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile.')),
          );
        }
      } catch (e) {
        // Handle errors (e.g., network issues, server errors)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _authController.getUser(); // Call the getUserData method

    _nameController = TextEditingController(text: _authController.nama.value);
    _emailController = TextEditingController(text: _authController.email.value);
    _phoneController = TextEditingController(text: _authController.phone.value);
    _addressController =
        TextEditingController(text: _authController.address.value);
    _farmNameController =
        TextEditingController(text: _authController.farmName.value);
    _farmAddressController =
        TextEditingController(text: _authController.farmAddress.value);
    _upahController = TextEditingController(text: _authController.upah.value);
  }

  @override
  void dispose() {
    // Dispose of controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _farmNameController.dispose();
    _farmAddressController.dispose();
    _upahController.dispose();
    super.dispose();
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
              child: RefreshIndicator(
                onRefresh: _refreshProfileData, // Panggil fungsi untuk refresh
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                          backgroundImage:
                                              _selectedImage != null
                                                  ? FileImage(_selectedImage!)
                                                  : NetworkImage(
                                                      _authController
                                                          .avatarUrl.value,
                                                    ),
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
                                      controller: _nameController,
                                      initialValue: _authController.nama.value),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                      label: 'Email',
                                      controller: _emailController,
                                      initialValue:
                                          _authController.email.value),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                      label: 'Phone Number',
                                      controller: _phoneController,
                                      initialValue:
                                          _authController.phone.value),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                      label: 'Address',
                                      controller: _addressController,
                                      initialValue:
                                          _authController.address.value),
                                  const SizedBox(height: 20),
                                  if (_authController.farm.value == 1) ...[
                                    _buildTextField(
                                        label: 'Farm Name',
                                        controller: _farmNameController,
                                        initialValue:
                                            _authController.farmName.value),
                                    const SizedBox(height: 20),
                                    _buildTextField(
                                        label: 'Farm Address',
                                        controller: _farmAddressController,
                                        initialValue:
                                            _authController.farmAddress.value),
                                    const SizedBox(height: 20),
                                  ],
                                  if (_authController.isPengangon.value ==
                                      1) ...[
                                    _buildTextField(
                                        label: 'Upah',
                                        controller: _upahController,
                                        initialValue:
                                            _authController.upah.value),
                                    const SizedBox(height: 20),
                                  ],
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF20A577),
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
          ),
        ],
      ),
    );
  }

// Fungsi untuk refresh data profil
  Future<void> _refreshProfileData() async {
    _authController.getUser(); // Panggil fungsi untuk mendapatkan data terbaru
    setState(() {}); // Update tampilan setelah data diperbarui
  }
}

// Widget _buildTextField({required String label, required String initialValue}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 8),
//       TextFormField(
//         initialValue: initialValue,
//         decoration: InputDecoration(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget _buildTextField({
  required String label,
  required String initialValue,
  TextEditingController? controller,
}) {
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
        controller: controller ?? TextEditingController(text: initialValue),
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
