import 'package:flutter/material.dart';
import 'package:release_manager_ui/constant.dart';

class CustomMultilineTextField extends StatefulWidget {
  final String title;
  final ValueChanged<String> onChanged;

  const CustomMultilineTextField({
    Key? key,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomMultilineTextField> createState() =>
      _CustomMultilineTextFieldState();
}

class _CustomMultilineTextFieldState extends State<CustomMultilineTextField> {
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
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
          ),
          onChanged: (String value) {
            _currentValue = value;
            widget.onChanged(value);
          },
        )
      ],
    );
  }
}
