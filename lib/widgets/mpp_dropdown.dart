import 'package:flutter/material.dart';

class MPPDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final double borderWidth;
  final List<Map<String, dynamic>>? dropdownItems;
  final Function(String?)? onChanged;
  final String? initialValue; // Add an optional initialValue parameter

  const MPPDropdown({
    Key? key,
    required this.controller,
    required this.label,
    this.borderWidth = 1.0,
    this.dropdownItems,
    this.onChanged,
    this.initialValue, // Initialize the initialValue parameter
  }) : super(key: key);

  @override
  _MPPDropdownState createState() => _MPPDropdownState();
}

class _MPPDropdownState extends State<MPPDropdown> {
  String? selectedId;

  @override
  void initState() {
    super.initState();
    // Set the selectedId based on initialValue
    selectedId = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            decoration: InputDecoration(
              filled: true, // Enables the fill color
              fillColor: Colors.white, // Sets the background color to white
              contentPadding: const EdgeInsets.all(8.0),
              border: InputBorder.none, // Removes the default border
            ),
          ),
        ),
      ],
    );
  }
}
