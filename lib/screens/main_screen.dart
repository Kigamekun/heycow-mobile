import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/beranda_module/beranda_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_screen.dart';
import 'package:heycowmobileapp/screens/community_module/community_screen.dart';
import 'package:heycowmobileapp/screens/qr_module/qr_screen.dart';
import 'package:heycowmobileapp/screens/user_module/user_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var _bottomNavIndex = 0;

  final CattleScreen cattleScreen = CattleScreen();
  final CommunityScreen communityScreen = CommunityScreen();

  // Define the pages for the BottomNavigationBar
  List<Widget> _buildScreens() {
    return [
      const BerandaScreen(),
      CattleScreen(key: cattleScreenKey),
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

  // Create a GlobalKey for CattleScreen
  final GlobalKey<CattleScreenState> cattleScreenKey =
      GlobalKey<CattleScreenState>();

  // Method to refresh the current screen
  Future<void> _refreshCurrentScreen() async {
    // Simulate a network call or any other asynchronous operation
    await Future.delayed(const Duration(seconds: 1));

    switch (_bottomNavIndex) {
      case 0: // Home screen
        break;
      case 1: // Search screen
        if (cattleScreenKey.currentState != null) {
          cattleScreenKey.currentState!.refreshData();
        }
        break;
      case 2: // Notifications screen
        break;
      case 3: // Profile screen
        break;
      case 4: // Cattle screen
        break;
      case 5: // Community screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of screens
    List<Widget> body = _buildScreens();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshCurrentScreen,
        child: Stack(
          children: [
            body[_bottomNavIndex],
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
      ),
    );
  }
}
