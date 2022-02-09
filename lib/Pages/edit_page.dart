import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  //when this page calls it will called with user existing id so we can update the user details
  final String id;

  const EditUser({Key? key, required this.id}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final keyForm = GlobalKey<FormState>();

  CollectionReference editUser =
      FirebaseFirestore.instance.collection('Students');

  ///update the existing user data
 Future updateUser(id, name, email, courseName) {
    return editUser
        .doc(id)
        .update({'name': name, "email": email, "courseName": courseName})
        .then((value) => print('User Updated'))
        .catchError((e)=> print('failed to update'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Form'),
        ),
        body: Form(
          key: keyForm,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            ///getting specific data by ID
            future: FirebaseFirestore.instance
                .collection('Students')
                .doc(widget.id)

                ///getting the user id from the list of students to update it
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Something went wrong!');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              ///no need to use map because we get single data
              var data = snapshot.data?.data();
              var name = data!['name'];
              var email = data['email'];
              var courseName = data['courseName'];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      initialValue: name,
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
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
                      initialValue: email,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'email',
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
                      initialValue: courseName,
                      onChanged: (value) {
                        courseName = value;
                      },
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
                              if (keyForm.currentState!.validate()) {
                                updateUser(widget.id, name, email, courseName);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 18),
                            )),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
