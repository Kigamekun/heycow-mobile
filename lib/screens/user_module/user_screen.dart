// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart'; // Import your AuthController
import 'package:heycowmobileapp/screens/auth_module/edit_profile_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/help_center_screen.dart';
import 'package:heycowmobileapp/screens/beranda_module/iot_screen.dart';
import 'package:heycowmobileapp/screens/user_module/register_pengangon_screen.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _authController.getUser(); // Call the getUserData method
  }

    void refreshData() {
    _authController.getUser(); // Call the getUserData method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBED),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff20A577),
                                  Color(0xff64CFAA),
                                ],
                                stops: [0.1, 0.5],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            height: 250,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 55),
                        ],
                      ),
                      Positioned(
                        top: 155,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status Pengangon',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _authController.isPengangon.value == 0
                                    ? 'Belum Terdaftar'
                                    : 'Sudah Terdaftar',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      if (_authController.isPengangon.value ==
                                              0 &&
                                          _authController.nik.value != '')
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Sedang dalam Progress',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      if (_authController.isPengangon.value ==
                                          1)
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                const RegisterPengangonScreen());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Edit Pengangon',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      if (_authController.isPengangon.value ==
                                              0 &&
                                          _authController.nik.value == '')
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                const RegisterPengangonScreen());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 16),
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Daftar Pengangon',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Get.to(() => const EditProfileScreen());
                              },
                              icon: const Icon(Icons.edit, color: Colors.green),
                              label: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Obx(() {
                            // Using Obx to listen to changes in the user observable
                            return Column(
                              children: [
                                _buildInfoTile(Icons.person_outline,
                                    _authController.nama.value),
                                _buildInfoTile(Icons.email_outlined,
                                    _authController.email.value),
                                _buildInfoTile(Icons.phone_outlined,
                                    _authController.phone.value),
                                _buildInfoTile(Icons.agriculture_outlined,
                                    _authController.farmName.value),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildOptionTile(
                                Icons.help_outline,
                                'Help Center',
                                onTap: () {
                                  Get.to(() => const HelpCenterScreen());
                                },
                              ),
                              _buildOptionTile(
                                Icons.device_hub,
                                'IOT Device',
                                onTap: () {
                                  Get.to(() =>  IOTScreen());
                                },
                              ),
                              _buildOptionTile(
                                Icons.logout,
                                'Log Out',
                                iconColor: Colors.red,
                                textColor: Colors.red,
                                onTap: () {
                                  _authController.logout();
                                  Get.offAllNamed('/login');
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildOptionTile(IconData icon, String label,
      {Color iconColor = Colors.green,
      Color textColor = Colors.black,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        label,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
      onTap: onTap,
    );
  }
}

Widget _buildOptionTile(IconData icon, String label,
    {Color iconColor = Colors.green,
    Color textColor = Colors.black,
    required Function() onTap}) {
  return ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(
      label,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
    onTap: onTap, // Add the onTap callback
  );
}
