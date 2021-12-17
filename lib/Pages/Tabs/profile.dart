import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('created: 11/12/2021', style: TextStyle(
              fontSize: 15,
              color: Colors.grey
            ),),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.0,),
            child: CircleAvatar(
              radius: 50,
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Text('User Id: skckedjvojv24ksvjsn76', style: TextStyle(
              fontSize: 14,
              color: Color(0xFFF9A826)
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Email: birjo@gmail.com', style: TextStyle(
                fontSize: 17
              ),),
              TextButton(
                  onPressed: (){},
                  child: const Text('Verify now'))
            ],
          ),


        ],
      )
    );
  }
}