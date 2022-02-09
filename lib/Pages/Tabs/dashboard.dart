import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../edit_page.dart';
import '../enrollment_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //variable where we will fetch our data from firestore "students collection"
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Students').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong!');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          ///created empty list to store our data
          final List storeDocs = [];

          ///data? can never be null
          ///fetching documents data as a Map
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storeDocs.add(a); ///adding data into empty list
            a['id'] = document.id; ///adding document id


          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Enrolled Students List',
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EnrollmentPage()));
                        },
                        child: const Text(
                          'Enroll Now',
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        3: FlexColumnWidth(140),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.yellow,
                            child: const Center(
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.yellow,
                            child: const Center(
                              child: Text(
                                'Course',
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.yellow,
                            child: const Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                        ]),
                        for (var i = 0; i < storeDocs.length; i++) ...[
                          TableRow(children: [
                            TableCell(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  storeDocs[i]['name'],
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                            TableCell(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              child:  Center(
                                child: Text(
                                  storeDocs[i]['courseName'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                            TableCell(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                     EditUser(id: storeDocs[i]['id'])));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteUser(storeDocs[i]['id']);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            )),
                          ]),
                        ]
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  ///for deleting user
  CollectionReference students = FirebaseFirestore.instance.collection('Students');
  Future deleteUser(id) {

    ///when the delete button pressed, it goes to the var students, doc id and deleted it after it print the "User deleted if error occurs it prints "failed to delete
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error)=>print('Failed to delete user $error'));
  }
}
