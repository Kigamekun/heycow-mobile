import 'package:flutter/material.dart';
import 'package:heycowmobileapp/app/theme.dart';

class MPPListTile extends StatelessWidget {
  final IconData leading;
  final String header;
  final String? description;

  const MPPListTile({
    Key? key,
    required this.leading,
    required this.header,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconColor = MPPColorTheme.darkOrangeColor;
    final Color headerColor = MPPColorTheme.darkOrangeColor;

    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: Icon(
          leading,
          size: 36,
          color: iconColor,
        ),
      ),
      title: Text(
        header,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: headerColor,
        ),
      ),
      subtitle: description != null
          ? Text(
              description!,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(138, 138, 138, 1)),
            )
          : null,
    );
  }
}
