import 'package:authentication_firebase/Pages/login_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Pages/Tabs/profile.dart';

void main(){
  //Initialize the firebase app
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          //checking exceptions
          if(snapshot.hasError){
            if (kDebugMode) {
              print('Something went wrong!');
            }
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return  const MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  Login(),
          );
        });




  }
}
