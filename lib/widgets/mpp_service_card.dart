import 'package:flutter/material.dart';
import 'package:heycowmobileapp/widgets/mpp_badge.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';
import 'package:heycowmobileapp/app/theme.dart';

class MPPServiceCard extends StatelessWidget {
  final String imageUrl;
  final String badgeText;
  final Color badgeColor;
  final String date;
  final String organization;
  final String serviceName;
  final String buttonText;
  final VoidCallback onPressed;

  const MPPServiceCard({
    super.key,
    required this.imageUrl,
    required this.badgeText,
    required this.badgeColor,
    required this.date,
    required this.organization,
    required this.serviceName,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(79, 76, 76, 0.25),
            offset: Offset(0, 1),
            blurRadius: 5.0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPPBadge(
                      text: badgeText,
                      color: badgeColor,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      organization,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          MPPButton(
            text: buttonText,
            onPressed: onPressed,
            backgroundColor: MPPColorTheme.coralBlueColor,
          ),
        ],
      ),
    );
  }
}
