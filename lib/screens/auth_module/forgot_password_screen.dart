import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';
import 'package:heycowmobileapp/widgets/mpp_list_tile.dart';
import 'package:heycowmobileapp/widgets/mpp_textfield.dart';
import 'package:heycowmobileapp/app/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();
  final double screenPadding = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(left: screenPadding, right: screenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MPPImage(width: 150),
              const MPPListTile(
                  leading: Icons.arrow_circle_right_outlined,
                  header: "Masukkan alamat Email",
                  description: "Untuk proses selanjutnya"),
              const SizedBox(height: 20),
              MPPTextField(
                onChanged: (value) => authController.email.value = value,
                label: 'Email',
              ),
              const SizedBox(height: 20),
              MPPButton(
                text: 'Reset Password',
                onPressed: () => authController.reset(),
                backgroundColor: MPPColorTheme.darkTailColor,
              ),
            ],
          )),
    );
  }
}
