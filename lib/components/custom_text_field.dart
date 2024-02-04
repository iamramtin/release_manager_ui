import 'package:flutter/material.dart';
import 'package:release_manager_ui/constant.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String initValue;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.initValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late String _currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, color: lightBlue),
          ),
        ),
        Container(
          height: 30,
          child: TextFormField(
            key: Key(widget.initValue),
            initialValue: widget.initValue,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
            ),
            onChanged: (String value) {
              setState(() {
                _currentValue = value;
                widget.onChanged(value);
              });
            },
          ),
        )
      ],
    );
  }
}
