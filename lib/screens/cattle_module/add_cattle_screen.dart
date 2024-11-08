import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/models/breed.dart'; // Import your controller
import 'package:heycowmobileapp/models/cattle.dart'; // Import your controller
import 'package:heycowmobileapp/widgets/mpp_dropdown.dart'; // Import your MPPDropdown widget

class AddCattleScreen extends StatefulWidget {
  const AddCattleScreen({super.key});

  @override
  State<AddCattleScreen> createState() => _AddCattleScreenState();
}

class _AddCattleScreenState extends State<AddCattleScreen> {
  final CattleController cattleController = Get.put(CattleController());

  final _formKey = GlobalKey<FormState>();
  Breed? selectedBreed;
  List<Breed> filteredBreeds = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // Controller for the date

  String nameSapi = '';
  String jenisSapi = '';
  DateTime selectedDate = DateTime.now();
  double tinggiSapi = 0;
  double beratSapi = 0;
  String kelaminSapi = '';
  String? selectedType;
  String? selectedHealthStatus;
  String healthStatus = '';
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
        _dateController.text =
            "${picked.day}-${picked.month}-${picked.year}"; // Update the controller
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cattleController.fetchBreedItems().then((_) {
      setState(() {
        // Triggers rebuild after breed items are fetched
      });
    });
    filteredBreeds = cattleController.breedItems;
    _searchController.addListener(_filterBreeds);
    _dateController.text =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"; // Initial date
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dateController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _filterBreeds() {
    setState(() {
      filteredBreeds = cattleController.breedItems
          .where((breed) => breed.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
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
                    // const AlertBox(),
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

                                  const Text('Nama Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  // Tinggi Sapi
                                  TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        nameSapi = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Kosongkan maka nama akan diisi otomatis',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                0xFF20A577)), // Warna border ketika TextField fokus
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika ada error
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika fokus dan ada error
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  const Text('Jenis Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),

                                  DropdownButtonFormField<String>(
                                    items: cattleController.breedItems
                                        .map((breed) {
                                      return DropdownMenuItem<String>(
                                        value: breed.id.toString(),
                                        child: Text(breed.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBreed = cattleController
                                            .breedItems
                                            .firstWhere(
                                          (breed) =>
                                              breed.id.toString() == value,
                                          orElse: () => Breed(id: 0, name: ''),
                                        );
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Pilih Ras Sapi',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF20A577)),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),
                                  const Text('Tanggal Lahir Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: AbsorbPointer(
                                      child: TextField(
                                        controller:
                                            _dateController, // Use controller
                                        decoration: const InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.calendar_today),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      219, 218, 218, 1))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Type Dropdown
                                  const Text('Tipe Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    items: [
                                      'perah',
                                      'pedaging',
                                      'peranakan',
                                      'lainnya',
                                    ].map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Pilih Tipe Sapi',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF20A577)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Health Status Dropdown
                                  const Text('Status Kesehatan*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    items: [
                                      'sehat',
                                      'sakit',
                                      'mati',
                                      'dijual',
                                    ].map((status) {
                                      return DropdownMenuItem<String>(
                                        value: status,
                                        child: Text(status),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        healthStatus = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Pilih Status Kesehatan',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF20A577)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('Tinggi Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  // Tinggi Sapi
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        tinggiSapi = double.parse(value);
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Tinggi Sapi (Cm)',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                0xFF20A577)), // Warna border ketika TextField fokus
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika ada error
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika fokus dan ada error
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('Berat Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  // Berat Terakhir Sapi
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        beratSapi = double.parse(value);
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Berat Terakhir Sapi (Kg)',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                0xFF20A577)), // Warna border ketika TextField fokus
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika ada error
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .red), // Warna border ketika fokus dan ada error
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Kelamin Sapi
                                  const Text('Kelamin Sapi*',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GenderButton(
                                        label: 'Jantan',
                                        icon: Icons.male,
                                        color: Colors.blue,
                                        isSelected: kelaminSapi == 'jantan',
                                        onTap: () {
                                          setState(() {
                                            kelaminSapi = 'jantan';
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 16),
                                      GenderButton(
                                        label: 'Betina',
                                        icon: Icons.female,
                                        color: Colors.pink,
                                        isSelected: kelaminSapi == 'betina',
                                        onTap: () {
                                          setState(() {
                                            kelaminSapi = 'betina';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Submit button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Creating a Cattle object
                                          final newCattle = Cattle(
                                            name: nameSapi, // Use a TextField to capture name if required
                                            breedId: selectedBreed?.id ?? 0,
                                            gender: kelaminSapi,
                                            birthDate:
                                                "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
                                            birthWeight: beratSapi.toInt(),
                                            type: selectedType ?? '',
                                            status: healthStatus,
                                            birthHeight: tinggiSapi.toInt(),
                                            image:
                                                'image_url', // Replace with actual image path or URL
                                          );
                                          // Call the saveCattle function
                                          cattleController
                                              .saveCattle(newCattle);
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
}
