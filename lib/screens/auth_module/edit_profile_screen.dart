import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String jenisSapi = '';
  DateTime selectedDate = DateTime.now();
  double tinggiSapi = 0;
  double beratSapi = 0;
  String kelaminSapi = '';
  bool sudahVaksin = false;

  // Helper to pick date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set tombol back menjadi putih
        ),
        title: const Text('Tambah Ternak',
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
                    const AlertBox(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // Jenis Sapi

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
                                        const CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              'assets/pp.png'), // Replace with your image path
                                        ),
                                        const SizedBox(height: 10),
                                        TextButton(
                                          onPressed: () {
                                            // Logic for updating profile picture
                                          },
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

                                  // Username Field
                                  _buildTextField(
                                      label: 'Username',
                                      initialValue: 'Mulyadi'),

                                  const SizedBox(height: 20),

                                  // Email Field
                                  _buildTextField(
                                      label: 'Email',
                                      initialValue: 'mulyadi@ymail.vom'),

                                  const SizedBox(height: 20),

                                  // Phone Number Field
                                  _buildTextField(
                                      label: 'Phone Number',
                                      initialValue: '+1 234-567-890'),

                                  const SizedBox(height: 20),

                                  // Farm Name Field
                                  _buildTextField(
                                      label: 'Farm Name',
                                      initialValue: 'Mulyadi Farm'),

                                  const SizedBox(height: 40),

                                  const SizedBox(height: 16),
                                  // Submit button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Handle form submission
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Data Ternak berhasil disubmit')),
                                          );
                                        }
                                      },
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
                              )),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Floating Bottom Navigation Bar
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
