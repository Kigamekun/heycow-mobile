// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MPPTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String label;
//   final double borderWidth;
//   final bool isPassword;
//   final bool isNumeric;
//   final bool isMultiline; // New property for multiline

//   const MPPTextField({
//     Key? key,
//     required this.controller,
//     required this.label,
//     this.borderWidth = 1.0,
//     this.isPassword = false,
//     this.isNumeric = false,
//     this.isMultiline = false, // Default to single line
//   }) : super(key: key);

//   @override
//   _MPPTextFieldState createState() => _MPPTextFieldState();
// }

// class _MPPTextFieldState extends State<MPPTextField> {
//   bool isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 14,
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: widget.borderWidth,
//               color: const Color.fromRGBO(219, 218, 218, 1),
//             ),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: widget.isMultiline
//                     ? TextFormField(
//                         minLines: 5,
//                         controller: widget.controller,
//                         maxLines: null, // Allows multiple lines
//                         keyboardType: widget.isNumeric
//                             ? TextInputType.number
//                             : TextInputType.multiline,
//                         inputFormatters: widget.isNumeric
//                             ? <TextInputFormatter>[
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]')),
//                               ]
//                             : null,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.all(8.0),
//                           border: InputBorder.none,
//                         ),
//                       )
//                     : TextField(
//                         controller: widget.controller,
//                         obscureText: widget.isPassword && !isPasswordVisible,
//                         keyboardType: widget.isNumeric
//                             ? TextInputType.number
//                             : TextInputType.text,
//                         inputFormatters: widget.isNumeric
//                             ? <TextInputFormatter>[
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]')),
//                               ]
//                             : null,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.all(8.0),
//                           border: InputBorder.none,
//                         ),
//                       ),
//               ),
//               if (widget.isPassword)
//                 IconButton(
//                   icon: Icon(
//                     isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isPasswordVisible = !isPasswordVisible;
//                     });
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MPPTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String label;
  final double borderWidth;
  final bool isPassword;
  final bool isNumeric;
  final bool isMultiline; // New property for multiline
  final String? initialValue;
  final bool isDisabled;

  const MPPTextField({
    super.key,
    required this.onChanged,
    required this.label,
    this.borderWidth = 1.0,
    this.isPassword = false,
    this.isNumeric = false,
    this.isMultiline = false, // Default to single line
    this.initialValue,
    this.isDisabled = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MPPTextFieldState createState() => _MPPTextFieldState();
}

class _MPPTextFieldState extends State<MPPTextField> {
  late TextEditingController _textEditingController;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

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
          child: Row(
            children: [
              Expanded(
                child: widget.isMultiline
                    ? TextFormField(
                        initialValue: widget.initialValue,
                        minLines: 5,
                        controller: _textEditingController,
                        onChanged: widget.onChanged,
                        maxLines: null, // Allows multiple lines
                        enabled: !widget.isDisabled,
                        keyboardType: widget.isNumeric
                            ? TextInputType.number
                            : TextInputType.multiline,
                        inputFormatters: widget.isNumeric
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ]
                            : null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                        ),
                      )
                    : TextField(
                        controller: _textEditingController,
                        onChanged: widget.onChanged,
                        obscureText: widget.isPassword && !isPasswordVisible,
                        enabled: !widget.isDisabled,
                        keyboardType: widget.isNumeric
                            ? TextInputType.number
                            : TextInputType.text,
                        inputFormatters: widget.isNumeric
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ]
                            : null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                        ),
                      ),
              ),
              if (widget.isPassword)
                IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
