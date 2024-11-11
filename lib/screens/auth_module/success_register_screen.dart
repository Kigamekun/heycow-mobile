import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/screens/auth_module/login_screen.dart';
import 'package:heycowmobileapp/widgets/mpp_alert.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';

class SuccessRegisterScreen extends StatefulWidget {
  static const routeName = '/success-register';
  const SuccessRegisterScreen({super.key});

  @override
  State<SuccessRegisterScreen> createState() => _SuccessRegisterScreenState();
}

class _SuccessRegisterScreenState extends State<SuccessRegisterScreen> {
  final double screenPadding = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(
              left: screenPadding,
              right: screenPadding,
              top: screenPadding * 3,
              bottom: screenPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              const Expanded(
                child: Center(
                    child: MPPAlert(
                        imagePath: "assets/circular-success-filled.png",
                        title: "Pendaftaran Akun Berhasil!",
                        subtitle:
                            "Silahkan Lanjutkan Proses Login.")),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MPPButton(
                  text: 'Login Screen',
                  onPressed: () => Get.to(() => const LoginScreen()),
                  backgroundColor: const Color(0xff20A577),
                ),
              ),
            ],
          )),
    );
  }
}
