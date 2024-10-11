import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/widgets/mpp_alert.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';
import 'package:heycowmobileapp/screens/auth_module/activation_screen.dart';
import 'package:heycowmobileapp/app/theme.dart';

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
              const Align(
                alignment: Alignment.topCenter,
                child: MPPImage(width: 150),
              ),
              const Expanded(
                child: Center(
                    child: MPPAlert(
                        imagePath: "assets/circular-success-filled.png",
                        title: "Pendaftaran Akun Berhasil!",
                        subtitle:
                            "Silahkan cek alamat email anda untuk proses aktivasi akun")),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MPPButton(
                  text: 'Masukkan Kode Aktivasi',
                  onPressed: () => Get.to(() => const ActivationScreen()),
                  backgroundColor: MPPColorTheme.darkTailColor,
                ),
              ),
            ],
          )),
    );
  }
}
