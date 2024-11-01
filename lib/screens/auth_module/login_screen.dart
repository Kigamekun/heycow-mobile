import 'package:flutter/material.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/screens/auth_module/register_screen.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_textfield.dart';
import 'package:heycowmobileapp/screens/auth_module/forgot_password_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  final double screenPadding = 32.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          // Mengatur arah gradient dari atas ke bawah
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Warna-warna untuk gradient
          colors: [
            Color(0xff20A577), // Warna awal (atas)
            Color(0xff64CFAA), // Warna akhir (bawah)
          ],
          stops: [
            0.1, // Warna pertama berhenti di 1%
            0.5, // Warna kedua mengisi dari 1% sampai bawah
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true, // Tambahkan ini
        body: SingleChildScrollView(
          // Tambahkan SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: screenPadding, right: screenPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login Akun',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff20A577),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MPPTextField(
                      onChanged: (value) => authController.email.value = value,
                      label: 'Email',
                    ),
                    const SizedBox(height: 20),
                    MPPTextField(
                      onChanged: (value) =>
                          authController.password.value = value,
                      label: 'Kata Sandi',
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () =>
                            Get.toNamed(ForgotPasswordScreen.routeName),
                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            color: Color(0xff20A577),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MPPButton(
                      text: 'Masuk',
                      onPressed: () => authController.login(),
                      backgroundColor: const Color(0xff20A577),
                    ),
                    const SizedBox(height: 20),
                    // Jika belum punya akun, silahkan daftar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah punya akun? "),
                        TextButton(
                          onPressed: () => Get.to(() => const RegisterScreen()),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xff20A577),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
