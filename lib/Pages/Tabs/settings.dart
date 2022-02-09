import 'package:authentication_firebase/Pages/Tabs/profile.dart';
import 'package:authentication_firebase/Pages/login_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String userName = '';
  bool isHidden = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    passwordController.dispose();
    userNameController.dispose();
  }
  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try{
      await currentUser!.updatePassword(password);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF73b504),
          content: Text('Password has been changed! Please Login again.', style: TextStyle(color: Colors.black, fontFamily: 'Karla-Medium', fontSize: 18 ),)));
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }
  changeName() async {
    try{
      await currentUser!.updateDisplayName(userName);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Profile()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF73b504),
          content: Text('UserName has been changed!', style: TextStyle(color: Colors.black, fontFamily: 'Karla-Medium', fontSize: 18 ),)));
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              child: TextFormField(
                autofocus: false,
                obscureText: isHidden,
                controller: userNameController,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter new UserName';
                  } else{
                    return null;
                  }
                },
                decoration:  InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Karla-Bold'),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF9A826))
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF9A826))
                    ),
                    errorStyle: const TextStyle(fontSize: 15),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isHidden = !isHidden;
                      });
                    }, icon:  Icon(isHidden ? Icons.visibility : Icons.visibility_off, color: const Color(0xFFF9A826) ))

                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                setState(() {
                  userName = userNameController.text;
                });
                changeName();
              }
            }, child: const Text('Change UserName', style: TextStyle(
                color: Colors.black, fontSize: 17
            ),),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF9A826),
                  fixedSize: const Size(190,50)
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
              child: TextFormField(
                autofocus: false,
                obscureText: isHidden,
                controller: passwordController,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter password';
                  } else if (value.length <= 8){
                    return 'Password should be 8 characters long';
                  }else{
                    return null;
                  }
                },
                decoration:  InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Karla-Bold'),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF9A826))
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF9A826))
                    ),
                    errorStyle: const TextStyle(fontSize: 15),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isHidden = !isHidden;
                      });
                    }, icon:  Icon(isHidden ? Icons.visibility : Icons.visibility_off, color: const Color(0xFFF9A826) ))

                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                setState(() {
                  password = passwordController.text;
                });
                changePassword();
              }
            }, child: const Text('Change Password', style: TextStyle(
                color: Colors.black, fontSize: 17
            ),),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF9A826),
                  fixedSize: const Size(190,50)
              ),
            ),
          ],
        ),
      )
    );
  }
}