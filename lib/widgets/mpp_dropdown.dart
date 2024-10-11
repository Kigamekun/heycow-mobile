import 'package:flutter/material.dart';

class MPPDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final double borderWidth;
  final List<Map<String, dynamic>>? dropdownItems;
  final Function(String?)? onChanged;

  const MPPDropdown({
    Key? key,
    required this.controller,
    required this.label,
    this.borderWidth = 1.0,
    this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  @override
  _MPPDropdownState createState() => _MPPDropdownState();
}

class _MPPDropdownState extends State<MPPDropdown> {
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: widget.borderWidth,
              color: const Color.fromRGBO(219, 218, 218, 1),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedId,
            items: widget.dropdownItems!
                .map((item) => DropdownMenuItem<String>(
                      value: item['id'].toString(),
                      child: Text(item['label'] as String),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedId = newValue;
                widget.controller.text = newValue ?? '';
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              });
            },
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
