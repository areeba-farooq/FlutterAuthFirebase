import 'package:authentication_firebase/Pages/login_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Tabs/dashboard.dart';
import 'Tabs/profile.dart';
import 'Tabs/settings.dart';

class HomeAuth extends StatefulWidget {
  const HomeAuth({Key? key}) : super(key: key);

  @override
  _HomeAuthState createState() => _HomeAuthState();
}

class _HomeAuthState extends State<HomeAuth> {
  int selectedIndex = 0;
  static List<Widget> tabWidgets = <Widget>[
    const DashBoard(),
    const Profile(),
    const Settings()
  ];
//Color(0xFFF9A826)
  void onSelectedItem(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));

          }, icon: const Icon(Icons.logout))
        ],
      ),
      drawer: const Drawer(),
      body: tabWidgets.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFF9A826),
        onTap: onSelectedItem,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'DashBoard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings')
        ],
      ),
    );
  }
}
