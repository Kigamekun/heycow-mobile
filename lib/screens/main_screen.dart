import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/beranda_module/beranda_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_screen.dart';
import 'package:heycowmobileapp/screens/community_module/community_screen.dart';
import 'package:heycowmobileapp/screens/qr_module/qr_screen.dart';
import 'package:heycowmobileapp/screens/user_module/user_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var _bottomNavIndex = 0;

  // Define the pages for the BottomNavigationBar
  List<Widget> _buildScreens() {
    return [
      const BerandaScreen(),
      const CattleScreen(),
      const QRScreen(),
      const CommunityScreen(),
      const UserScreen()
    ];
  }

  // Handle navigation based on the tapped index
  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of screens
    List<Widget> body = _buildScreens();

    return Scaffold(
      body: Stack(
        children: [
          // The body content based on the selected index
          body[_bottomNavIndex],

          // Floating Bottom Navigation Bar
          Positioned(
            bottom: 16, // Adjust the position from the bottom
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x33959DA5),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _bottomNavIndex,
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: PhosphorIcon(
                      PhosphorIconsFill.squaresFour,
                      size: 25.0,
                      semanticLabel: 'New Note',
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: PhosphorIcon(
                      PhosphorIconsFill.cow,
                      size: 25.0,
                      semanticLabel: 'New Note',
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: PhosphorIcon(
                      PhosphorIconsFill.scan,
                      size: 25.0,
                      semanticLabel: 'New Note',
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: PhosphorIcon(
                      PhosphorIconsFill.usersThree,
                      size: 25.0,
                      semanticLabel: 'New Note',
                    ),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: PhosphorIcon(
                      PhosphorIconsFill.user,
                      size: 25.0,
                      semanticLabel: 'New Note',
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
