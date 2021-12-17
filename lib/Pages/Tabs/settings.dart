import 'package:authentication_firebase/Pages/login_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String password = '';
  bool isHidden = true;
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Kindly type your Old password', style: TextStyle(
              fontSize: 20,
              fontFamily: 'Karla-Medium'
            ),),
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
                    }, icon:  Icon(isHidden ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFF9A826) ))

                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                setState(() {
                  password = passwordController.text;
                });
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));

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