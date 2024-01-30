import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:session11_sqlite_db/db/database_helper.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/screens/student_list_screen.dart';
import 'package:session11_sqlite_db/utility/data_store.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, email, mobile;

  String _selectedCourse = courses[0];
  String _selectedUniversity = university[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              _buildInputField(
                label: 'Name',
                icon: Icons.person,
                onChanged: (text) {
                  name = text;
                },
                validator: (text) {
                  return (text == null || text.isEmpty) ? 'Please provide value' : null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Email',
                icon: Icons.email,
                onChanged: (text) {
                  email = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  } else if (!isValidEmail(text)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Mobile',
                icon: Icons.phone,
                hintText: 'xxxx-xxxxxxx',
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  mobile = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  } else if (!isValidMobile(text)) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Course',
                icon: Icons.book,
                value: _selectedCourse,
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? "Can't be empty" : null;
                },
                items: courses,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'University',
                icon: Icons.school,
                value: _selectedUniversity,
                onChanged: (value) {
                  setState(() {
                    _selectedUniversity = value!;
                  });
                },
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? "Can't be empty" : null;
                },
                items: university,
              ),
              const SizedBox(height: 16),
              _buildElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Student student = Student(
                      name: name,
                      email: email,
                      mobile: mobile,
                      course: _selectedCourse,
                      uni: _selectedUniversity,
                    );

                    int result = await DatabaseHelper.instance.saveStudent(student);

                    if (result > 0) {
                      Fluttertoast.showToast(msg: 'Record Saved', backgroundColor: Colors.green);
                      formKey.currentState!.reset();
                    } else {
                      Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);
                    }
                  }
                },
                label: 'Save',
              ),
              const SizedBox(height: 16),
              _buildElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const StudentListScreen();
                  }));
                },
                label: 'View All',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required void Function(String?) onChanged,
    required String? Function(String?)? validator,
    required List<String> items,
  }) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      isExpanded: true,
      onChanged: onChanged,
      validator: validator,
      items: items.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    );
  }

  Widget _buildElevatedButton({
    required void Function()? onPressed,
    required String label,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.indigo,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+@[\w-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  bool isValidMobile(String mobile) {
    RegExp regex = RegExp(r'^(\+92|0)?[3456789]\d{9}$');
    return regex.hasMatch(mobile);
  }
}
