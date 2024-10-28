import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _formKey = GlobalKey<FormState>();
  String jenisSapi = '';
  DateTime selectedDate = DateTime.now();
  double tinggiSapi = 0;
  double beratSapi = 0;
  String kelaminSapi = '';
  bool sudahVaksin = false;

  // Helper to pick date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set tombol back menjadi putih
        ),
        title: const Text('Help Center',
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              suffixIcon: const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          // Question Options Dropdown
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Opsi Pertanyaan',
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Kerusakan Aplikasi',
                                child: Text('Kerusakan Aplikasi'),
                              ),
                              DropdownMenuItem(
                                value: 'Pengiriman',
                                child: Text('Pengiriman'),
                              ),
                              DropdownMenuItem(
                                value: 'Lainnya',
                                child: Text('Lainnya'),
                              ),
                            ],
                            onChanged: (value) {
                              // Handle change
                            },
                          ),
                          const SizedBox(height: 16),

                          // Detail Question Text Field
                          TextFormField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Detail Pertanyaan',
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle form submission
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Data Ternak berhasil disubmit')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF20A577),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
}
