import 'package:flutter/material.dart';

class MPPDropdownBug {
  MPPDropdownBug._();

  static Widget buildDropDown({
    required String title,
    required String subtitle,
    required Object? value,
    required List<DropdownMenuItem<Object>>? items,
    required Function(Object?)? onChanged,
    FormFieldValidator<Object?>? validator,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: const Color.fromRGBO(219, 218, 218, 1),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownButtonFormField(
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
