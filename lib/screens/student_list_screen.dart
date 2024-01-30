import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:session11_sqlite_db/db/database_helper.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/widgets/student_card_widget.dart';
import 'package:session11_sqlite_db/widgets/student_item_info_widget.dart';
import 'package:sqflite/sqflite.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student List',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Choose an appropriate color
        elevation: 5.0, // Add elevation for a subtle shadow
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  'No students found',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            List<Student> students = snapshot.data;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: students.length,
              itemBuilder: (context, index) {
                Student student = students[index];

                return StudentCardWidget(
                  student: student,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure to delete?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.red), // Choose a contrasting color
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                int result = await DatabaseHelper.instance.deleteStudent(student.id!);

                                if (result > 0) {
                                  Fluttertoast.showToast(msg: 'Deleted');
                                  setState(() {});
                                } else {
                                  Fluttertoast.showToast(msg: 'Failed');
                                }
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.green), // Choose a contrasting color
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onUpdate: () {},
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Choose an appropriate color
              ),
            );
          }
        },
      ),
    );
  }
}
