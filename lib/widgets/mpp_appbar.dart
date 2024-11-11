import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heycowmobileapp/controllers/auth_controller.dart';
import 'package:heycowmobileapp/screens/auth_module/profile_screen.dart';
import 'package:heycowmobileapp/widgets/mpp_image.dart';

class MPPAppBar extends StatelessWidget implements PreferredSizeWidget {
  MPPAppBar({
    super.key,
  });

  final AuthController _authController = Get.find<AuthController>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      leadingWidth: 100,
      leading: const Padding(
        padding: EdgeInsets.only(left: 14.0),
        child: MPPImage(),
      ),
      actions: [
        Obx(() {
          if (_authController.avatarUrl.isEmpty) {
            // handle if empty image
            return GestureDetector(
                onTap: () => Get.to(() => const ProfileScreen()),
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                ));
          } else {
            return GestureDetector(
              onTap: () => Get.to(
                  () => const ProfileScreen()), // Use the provided callback
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_authController.avatarUrl.toString()),
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}
