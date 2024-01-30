// student_card_widget.dart
import 'package:flutter/material.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/widgets/student_item_info_widget.dart';

class StudentCardWidget extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const StudentCardWidget({
    Key? key,
    required this.student,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[50],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 12.0),
            StudentItemInfoWidget(
              title: 'ID',
              value: student.id.toString(),
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black87),
            ),
            StudentItemInfoWidget(
              title: 'Name',
              value: student.name,
              textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            StudentItemInfoWidget(
              title: 'Email',
              value: student.email,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            StudentItemInfoWidget(
              title: 'Mobile',
              value: student.mobile,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            StudentItemInfoWidget(
              title: 'Course',
              value: student.course,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            StudentItemInfoWidget(
              title: 'Uni',
              value: student.uni,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDelete,
                    child: const Text('Delete', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onUpdate,
                    child: const Text('Update', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
