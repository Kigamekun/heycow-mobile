import 'package:flutter/material.dart';
import 'package:heycowmobileapp/widgets/mpp_button.dart';

class MPPBookingCard extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String time;
  final String organization;
  final String serviceName;
  final Color buttonColor;
  final String buttonText;
  final VoidCallback onPressed;

  const MPPBookingCard({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.organization,
    required this.serviceName,
    required this.buttonColor,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: const [
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
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organization,
                          style: const TextStyle(
                            fontSize: 14.0,
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
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 10,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 10,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          MPPButton(
            text: buttonText,
            onPressed: onPressed,
            backgroundColor: buttonColor,
          ),
        ],
      ),
    );
  }
}
