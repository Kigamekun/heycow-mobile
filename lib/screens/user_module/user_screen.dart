import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/beranda';

  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
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
                                  Color(0xff20A577), // Top color
                                  Color(0xff64CFAA), // Bottom color
                                ],
                                stops: [0.1, 0.5],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            height: 250, // Height of the gradient container
                            width: double.infinity,
                          ),
                          const SizedBox(height: 55),
                        ],
                      ),
                      Positioned(
                        top: 160,
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
                                'Subscription Status',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Basic Plan',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Button with 80% width and centered
                              Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.8, // 80% of screen width
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16), // Rounded corners
                                      ),
                                    ),
                                    onPressed: () {
                                      // Implement Upgrade Action
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        'Upgrade Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
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
                        // Personal Information Section
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
                                // Implement Edit Action
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

                        // Personal Information Items
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildInfoTile(Icons.person_outline, 'name'),
                              _buildInfoTile(Icons.email_outlined, 'email'),
                              _buildInfoTile(
                                  Icons.phone_outlined, 'phone number'),
                              _buildInfoTile(
                                  Icons.agriculture_outlined, 'farm name'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Other Options Section
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildOptionTile(
                                  Icons.help_outline, 'help center'),
                              _buildOptionTile(
                                  Icons.forum_outlined, 'community'),
                              _buildOptionTile(
                                  Icons.catching_pokemon_outlined, 'cattle'),
                              _buildOptionTile(
                                Icons.logout,
                                'log out',
                                iconColor: Colors.red,
                                textColor: Colors.red,
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
          // Floating Bottom Navigation Bar
        ],
      ),
    );
  }
}

Widget _buildInfoTile(IconData icon, String label) {
  return ListTile(
    leading: Icon(icon, color: Colors.green),
    title: Text(label, style: const TextStyle(fontSize: 16)),
  );
}

Widget _buildOptionTile(IconData icon, String label,
    {Color iconColor = Colors.green, Color textColor = Colors.black}) {
  return ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(
      label,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
  );
}
