import 'package:flutter/material.dart';
import 'package:heycowmobileapp/screens/beranda_module/beranda_screen.dart';
import 'package:heycowmobileapp/screens/cattle_module/cattle_screen.dart';
import 'package:heycowmobileapp/screens/community_module/community_screen.dart';
import 'package:heycowmobileapp/screens/qr_module/qr_screen.dart';
import 'package:heycowmobileapp/screens/user_module/user_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late int _bottomNavIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex; // Set initial index
  }

  final CattleScreen cattleScreen = const CattleScreen();
  final CommunityScreen communityScreen = const CommunityScreen();
  final UserScreen userScreen = const UserScreen();

  List<Widget> _buildScreens() {
    return [
      const BerandaScreen(),
      CattleScreen(key: cattleScreenKey),
      const QRScreen(),
      const CommunityScreen(),
      const UserScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final GlobalKey<CattleScreenState> cattleScreenKey =
      GlobalKey<CattleScreenState>();
    
    final GlobalKey<UserScreenState> userScreenKey =
      GlobalKey<UserScreenState>();

  Future<void> _refreshCurrentScreen() async {
    // await Future.delayed(const Duration(seconds: 1));
    if (_bottomNavIndex == 1 && cattleScreenKey.currentState != null) {
      cattleScreenKey.currentState!.refreshData();
    } else if (_bottomNavIndex == 4 && userScreenKey.currentState != null) {
      print('ada disni');
      userScreenKey.currentState!.refreshData();
    }

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = _buildScreens();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshCurrentScreen,
        child: Stack(
          children: [
            body[_bottomNavIndex],
            Positioned(
              bottom: 16,
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
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: PhosphorIcon(
                        PhosphorIconsFill.cow,
                        size: 25.0,
                      ),
                      label: 'Cattle',
                    ),
                    BottomNavigationBarItem(
                      icon: PhosphorIcon(
                        PhosphorIconsFill.scan,
                        size: 25.0,
                      ),
                      label: 'QR',
                    ),
                    BottomNavigationBarItem(
                      icon: PhosphorIcon(
                        PhosphorIconsFill.usersThree,
                        size: 25.0,
                      ),
                      label: 'Community',
                    ),
                    BottomNavigationBarItem(
                      icon: PhosphorIcon(
                        PhosphorIconsFill.user,
                        size: 25.0,
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
