
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/auth_module/activation_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/forgot_password_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/register_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/reset_password_failed_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/reset_password_success_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/success_register_screen.dart';
import 'package:heycowmobileapp/screens/beranda_module/beranda_screen.dart';
import 'package:heycowmobileapp/screens/main_screen.dart';
import 'package:heycowmobileapp/screens/auth_module/login_screen.dart';
import 'package:heycowmobileapp/screens/splash_screen.dart';

class RoutesManager {
  static final List<GetPage> routes = [
    GetPage(name: MainScreen.routeName, page: () => const MainScreen()),
    GetPage(name: BerandaScreen.routeName, page: () => const BerandaScreen()),
    GetPage(name: BerandaScreen.routeName, page: () => const BerandaScreen()),
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
    GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
    GetPage(name: ForgotPasswordScreen.routeName, page: () => const ForgotPasswordScreen()),
    GetPage(name: ResetPasswordSuccessScreen.routeName, page: () => const ResetPasswordSuccessScreen()),
    GetPage(name: ResetPasswordFailedScreen.routeName, page: () => const ResetPasswordFailedScreen()),
    GetPage(name: RegisterScreen.routeName, page: () => const RegisterScreen()),
    GetPage(name: SuccessRegisterScreen.routeName, page: () => const SuccessRegisterScreen()),
    GetPage(name: ActivationScreen.routeName, page: () => const ActivationScreen()),
    GetPage(
      name: '/noRouteDefined', // This is a route for undefined routes
      page: () => const Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      ),
    ),
  ];
}