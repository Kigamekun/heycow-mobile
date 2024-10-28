import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/models/breed.dart'; // Import your breed model
import 'package:heycowmobileapp/models/cattle.dart'; // Import your cattle model
import 'package:heycowmobileapp/widgets/mpp_dropdown.dart'; // Import your MPPDropdown widget

class EditCattleScreen extends StatefulWidget {
  final Cattle? cattle; // Add a cattle parameter for updating

  const EditCattleScreen({super.key, this.cattle});

  @override
  State<EditCattleScreen> createState() => _EditCattleScreenState();
}

class _EditCattleScreenState extends State<EditCattleScreen> {
  final CattleController cattleController = Get.put(CattleController());

  final _formKey = GlobalKey<FormState>();
  Breed? selectedBreed;
  List<Breed> filteredBreeds = [];
  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _tinggiSapiController = TextEditingController();
  TextEditingController _beratSapiController = TextEditingController();

  String jenisSapi = '';
  DateTime selectedDate = DateTime.now();
  double tinggiSapi = 0;
  double beratSapi = 0;
  String kelaminSapi = '';
  String? selectedType;
  String? selectedHealthStatus;
  String healthStatus = '';
  bool sudahVaksin = false;

  @override
  void initState() {
    super.initState();
    cattleController.fetchBreedItems();
    filteredBreeds = cattleController.breedItems;
    _searchController.addListener(_filterBreeds);

    // Initialize fields for update
    if (widget.cattle != null) {
      // Set breed
      jenisSapi = widget.cattle!.breedId.toString();

      selectedDate = DateTime.parse(widget.cattle!.birthDate as String);
      _dateController.text =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

      tinggiSapi = widget.cattle!.birthHeight!.toDouble();
      beratSapi = widget.cattle!.birthWeight!.toDouble();

      _tinggiSapiController.text = tinggiSapi.toString();
      _beratSapiController.text = beratSapi.toString();

      kelaminSapi = widget.cattle!.gender as String;
      selectedType = widget.cattle!.type;
      healthStatus = widget.cattle!.status;
    } else {
      _dateController.text =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"; // Initial date
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
                                const SizedBox(height: 16),
                                // Dropdown for selecting breed
                                MPPDropdown(
                                  controller: TextEditingController(),
                                  label: 'Jenis Sapi*',
                                  initialValue:
                                      jenisSapi, // Set the initial value
                                  dropdownItems:
                                      cattleController.breedItems.map((breed) {
                                    return {
                                      'id': breed.id,
                                      'label': breed.name,
                                    };
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBreed = value != null
                                          ? cattleController.breedItems
                                              .firstWhere((breed) =>
                                                  breed.id.toString() == value)
                                          : null;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text('Tanggal Lahir Sapi*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller:
                                          _dateController, // Use controller
                                      decoration: const InputDecoration(
                                        labelText: 'Tanggal Lahir Sapi',
                                        suffixIcon: Icon(Icons.calendar_today),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF20A577)),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Type Dropdown
                                const Text('Tipe Sapi*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value:
                                      selectedType, // Set the initial selected value
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
                                      borderSide:
                                          BorderSide(color: Color(0xFF20A577)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Health Status Dropdown
                                const Text('Status Kesehatan*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value:
                                      healthStatus, // Set the initial selected value
                                  items: [
                                    'sehat',
                                    'sakit',
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
                                      borderSide:
                                          BorderSide(color: Color(0xFF20A577)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text('Tinggi Sapi*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                // Tinggi Sapi
                                TextField(
                                  controller: _tinggiSapiController,
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
                                      borderSide:
                                          BorderSide(color: Color(0xFF20A577)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text('Berat Sapi*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                // Berat Sapi
                                TextField(
                                  controller: _beratSapiController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      beratSapi = double.parse(value);
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Berat Sapi (Kg)',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF20A577)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text('Kelamin Sapi*',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value:
                                      kelaminSapi, // Set the initial selected value
                                  items: [
                                    'jantan',
                                    'betina',
                                  ].map((kelamin) {
                                    return DropdownMenuItem<String>(
                                      value: kelamin,
                                      child: Text(kelamin),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      kelaminSapi = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Pilih Kelamin Sapi',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF20A577)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Creating a Cattle object
                                        final newCattle = Cattle(
                                          id: widget.cattle?.id,
                                          name:
                                              'Nama Sapi', // Use a TextField to capture name if required
                                          breedId: selectedBreed?.id ??
                                              widget.cattle!.breedId,
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
                                        cattleController
                                            .updateCattle(newCattle);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Data Ternak berhasil disubmit')),
                                        );
                                      }
                                    },
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
                          const SizedBox(height: 16),

                          // Submit Button
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
}
