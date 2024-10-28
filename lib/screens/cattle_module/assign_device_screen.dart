import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/cattle_controller.dart';
import 'package:heycowmobileapp/models/breed.dart'; // Import your breed model
import 'package:heycowmobileapp/models/cattle.dart'; // Import your cattle model
// import 'package:heycowmobileapp/widgets/mpp_dropdown.dart'; // Import your MPPDropdown widget

import 'package:heycowmobileapp/app/constants_variable.dart';
// import 'package:heycowmobileapp/models/cattle.dart'; // Import your cattle model
import 'package:heycowmobileapp/controllers/auth_controller.dart';
// import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignDeviceScreen extends StatefulWidget {
  final Cattle? cattle; // Add a cattle parameter for updating

  const AssignDeviceScreen({super.key, this.cattle});

  @override
  State<AssignDeviceScreen> createState() => _AssignDeviceScreenState();
}

class _AssignDeviceScreenState extends State<AssignDeviceScreen> {
  final CattleController cattleController = Get.put(CattleController());

  final TextEditingController _typeAheadController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  Future<List<String>> _getSuggestions(String query) async {
    // Ganti URL ini dengan endpoint backend Anda
    final response = await http.post(
      Uri.parse(AppConstants.searchIOTDevices),
      headers: <String, String>{
        'Authorization': 'Bearer ${_authController.accessToken}',
      },
      body: jsonEncode(<String, String>{
        'query': query,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      List devices = json.decode(response.body);
      return devices
          .map((device) => device['serial_number'].toString())
          .toList();
    } else {
      throw Exception(
        'Failed to load suggestions',
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  Breed? selectedBreed;
  List<Breed> filteredBreeds = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cattleController.fetchBreedItems();
    filteredBreeds = cattleController.breedItems;
    _searchController.addListener(_filterBreeds);

    // Initialize fields for update
    if (widget.cattle != null) {
    } else {
      // Initial date
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: _typeAheadController,
                                      decoration: InputDecoration(
                                        labelText: 'Search IoT Device',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      return await _getSuggestions(pattern);
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      _typeAheadController.text = suggestion;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          // Assign IoT device (no need to fetch updated cattle here if your controller handles it)
                                          await cattleController
                                              .assignIOTDevice(
                                            widget.cattle!.id as int,
                                            _typeAheadController.text,
                                          );

                                          // Go back to CattleDetailScreen to indicate success
                                          Navigator.pop(context,
                                              true); // Returning true to indicate success
                                        } catch (e) {
                                          // Handle error
                                          print(
                                              "Failed to assign IoT device: $e");
                                        }
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
