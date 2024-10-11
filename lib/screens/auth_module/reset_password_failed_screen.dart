import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/widgets/mpp_alert.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';
import 'package:heycowmobileapp/app/theme.dart';

class ResetPasswordFailedScreen extends StatefulWidget {
  static const routeName = '/reset-password-success';
  const ResetPasswordFailedScreen({super.key});

  @override
  State<ResetPasswordFailedScreen> createState() =>
      _ResetPasswordFailedScreenState();
}

class _ResetPasswordFailedScreenState extends State<ResetPasswordFailedScreen> {
  TextEditingController emailController = TextEditingController();
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
                  alignment: Alignment.topCenter, child: MPPImage(width: 150)),
              const Expanded(
                child: Center(
                    child: MPPAlert(
                        imagePath: "assets/circular-failed-filled.png",
                        title: "Alamat Email tidak ditemukan",
                        subtitle:
                            "Pastikan alamat email yang anda masukkan sudah benar dan terdaftar")),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MPPButton(
                  text: 'Kembali',
                  onPressed: () => Get.back(),
                  backgroundColor: MPPColorTheme.darkTailColor,
                ),
              ),
            ],
          )),
    );
  }
}
