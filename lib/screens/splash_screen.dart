import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/screens/auth_module/login_screen.dart';
import 'package:heycowmobileapp/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  bool _showSecondSplash = false;

  @override
  void initState() {
    super.initState();

    // Show the first splash screen for 2 seconds before transitioning to the second one
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSecondSplash = true;
      });
    });

    // Check login status after showing the second splash screen
    Future.delayed(const Duration(seconds: 4), () {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await checkLogin();

    // Navigate to the appropriate screen with a fade transition
    _navigateWithFade(isLoggedIn ? const MainScreen() : const LoginScreen());
  }

  // Custom method to navigate with fade transition
  void _navigateWithFade(Widget screen) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the fade transition
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 500), // Duration for the fade effect
    ));
  }

  Future<bool> checkLogin() async {
    final box = GetStorage();
    final startTime = DateTime.now();
    const timeout = Duration(seconds: 5);

    while (DateTime.now().difference(startTime) < timeout) {
      final isLogin = box.read('isLogin');
      if (isLogin != null) {
        final getExpired = await box.read('expired_token');
        if (getExpired != null) {
          final storedDate = DateTime.tryParse(getExpired);
          if (storedDate != null) {
            final currentDate = DateTime.now();
            if (storedDate.isAfter(currentDate)) {
              final isSuccess = await _authController.getRefreshToken();
              if (isSuccess) {
                return true;
              }
            }
          }
        }
      }

      await Future.delayed(const Duration(milliseconds: 100));
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(
            milliseconds: 350), // Duration for the screen transition
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Custom transition: Slide in from bottom (for the second splash screen)
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1), // Start from off-screen at the bottom
            end: Offset.zero, // End at the center
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: _showSecondSplash ? _buildSecondSplash() : _buildFirstSplash(),
      ),
    );
  }

  Widget _buildFirstSplash() {
    return const Center(
      key: ValueKey(1), // Unique key for AnimatedSwitcher
      child: SizedBox(
        width: 150,
        child: Image(image: AssetImage('assets/heycowlogo.png')),
      ),
    );
  }

  Widget _buildSecondSplash() {
    return Container(
      key: const ValueKey(2), // Unique key for AnimatedSwitcher
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
      ),
      child: const Center(
        child: Text(
          'HeyCow',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
