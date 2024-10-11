import 'package:flutter/material.dart';
import 'package:heycowmobileapp/widgets/mpp_alert.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';
import 'package:heycowmobileapp/screens/auth_module/login_screen.dart';
import 'package:heycowmobileapp/app/theme.dart';

class ResetPasswordSuccessScreen extends StatefulWidget {
  static const routeName = '/reset-password-success';
  const ResetPasswordSuccessScreen({super.key});

  @override
  State<ResetPasswordSuccessScreen> createState() =>
      _ResetPasswordSuccessScreenState();
}

class _ResetPasswordSuccessScreenState
    extends State<ResetPasswordSuccessScreen> {
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
                alignment: Alignment.topCenter,
                child: MPPImage(width: 150),
              ),
              const Expanded(
                child: Center(
                    child: MPPAlert(
                        imagePath: "assets/circular-success-filled.png",
                        title: "Password berhasil direset",
                        subtitle:
                            "Silahkan cek alamat email anda untuk proses selanjutnya")),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MPPButton(
                  text: 'Masuk',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  backgroundColor: MPPColorTheme.darkTailColor,
                ),
              ),
            ],
          )),
    );
  }
}
