import 'package:flutter/material.dart';
import 'package:heycowmobileapp/widgets/mpp_badge.dart';
import 'package:heycowmobileapp/widgets/mpp_card.dart';
import 'package:heycowmobileapp/app/theme.dart';

// specific for detail pengaduan
class MPPDetailServiceCard extends StatelessWidget {
  final String badgeText;
  final Color badgeColor;
  final String date;
  final String organization;
  final String serviceName;
  final String question;
  final String answer;

  const MPPDetailServiceCard({
    Key? key,
    required this.badgeText,
    required this.badgeColor,
    required this.date,
    required this.organization,
    required this.serviceName,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MPPCard(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      color: MPPColorTheme.darkBrokenWhiteColor,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.chat_outlined,
                      size: 42.0,
                    )),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPPBadge(
                            text: badgeText,
                            color: badgeColor),
                        const SizedBox(height: 8.0),
                        Text(date, // Replace with your date
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
                        ), // Space between date and title
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
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Aduan/Saran/Pertanyaan :",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 10.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: MPPColorTheme.darkBrokenWhiteColor),
                    child: Text(
                      
                      question, style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 10.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        MPPCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Jawaban :",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: MPPColorTheme.darkBrokenWhiteColor),
                child: Text(
                  answer,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
