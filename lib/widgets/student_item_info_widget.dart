// student_item_info_widget.dart
import 'package:flutter/material.dart';

class StudentItemInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle textStyle;

  const StudentItemInfoWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: textStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          height: 1.0,
          color: Colors.black12,
        ),
      ],
    );
  }
}
