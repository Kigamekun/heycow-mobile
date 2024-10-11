import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';
import 'package:heycowmobileapp/app/theme.dart';

class ActivationScreen extends StatefulWidget {
  static const routeName = '/activation-account';
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final AuthController authController = Get.find<AuthController>();
  List<TextEditingController> digitControllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final double screenPadding = 32.0;

  int getEnteredDigits() {
    String enteredDigits = '';
    for (int i = 0; i < digitControllers.length; i++) {
      enteredDigits += digitControllers[i].text;
    }
    return int.parse(enteredDigits);
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < digitControllers.length; i++) {
      digitControllers[i].addListener(() {
        if (digitControllers[i].text.isNotEmpty) {
          if (i < digitControllers.length - 1) {
            FocusScope.of(context).requestFocus(focusNodes[i + 1]);
          } else {
            // The last digit has been entered, you can perform the desired action here
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < digitControllers.length; i++) {
      digitControllers[i].dispose();
      focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: screenPadding,
          right: screenPadding,
          top: screenPadding * 3,
          bottom: screenPadding * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: MPPImage(width: 150),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Silahkan Masukkan Kode Aktivasi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: const Color.fromRGBO(219, 218, 218, 1),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: 50.0,
                            child: TextField(
                              controller: digitControllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              decoration: const InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (index < 3) const SizedBox(width: 10),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MPPButton(
                text: 'Aktivasi Akun',
                onPressed: () =>
                    authController.activation(getEnteredDigits()),
                backgroundColor: MPPColorTheme.darkTailColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
