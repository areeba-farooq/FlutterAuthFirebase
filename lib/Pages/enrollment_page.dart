import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnrollmentPage extends StatefulWidget {
  const EnrollmentPage({Key? key}) : super(key: key);

  @override
  _EnrollmentPageState createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String courseName = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    emailController.dispose();
    nameController.dispose();
    courseNameController.dispose();
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    courseNameController.clear();
  }

  //adding students
  CollectionReference addStudents =
      FirebaseFirestore.instance.collection('Students');

   Future addUser() {
    return addStudents
        .add({'name': name, 'email': email, 'courseName': courseName})
        .then((value) => print('User added'))
        .catchError((e)=> print('failed to add user $e'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enrollment Form'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ListView(
              children: [
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorStyle: TextStyle(fontSize: 15)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email address';
                    } else if (!value.contains('@')) {
                      return 'Please enter Valid Email Address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorStyle: TextStyle(fontSize: 15)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: courseNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter course name';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'Course Name',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorStyle: TextStyle(fontSize: 15)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              name = nameController.text;
                              email = emailController.text;
                              courseName = courseNameController.text;
                              addUser();
                              clearText();
                            });
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        clearText();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
