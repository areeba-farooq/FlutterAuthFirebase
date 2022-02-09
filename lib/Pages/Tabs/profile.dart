import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser?.email;
  final createdTime = FirebaseAuth.instance.currentUser?.metadata.creationTime;
  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail()async{
    try{
      if(user != null && !user!.emailVerified){
        await user!.sendEmailVerification();
        user!.displayName;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0xFF73b504),
            content: Text('Verification link has been sent!', style: TextStyle(color: Colors.black, fontFamily: 'Karla-Medium', fontSize: 18 ),)));
      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('created: $createdTime', style: const TextStyle(
              fontSize: 15,
              color: Colors.grey
            ),),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 30),
            child: CircleAvatar(
              radius: 60,
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: Text(user!.displayName.toString(), style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFF9A826)
            ),),
          ),
          const SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: Text('User Id: $uid', style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFF9A826)
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Email: $email', style: const TextStyle(
                fontSize: 17
              ),),
              const SizedBox(width: 5,),
              user!.emailVerified? const ElevatedButton(onPressed: null, child: Text('Verified!')):
              TextButton(
                  onPressed: () {
                    verifyEmail();
                  },
                  child: const Text('Verify now'))
            ],
          ),


        ],
      )
    );
  }
}