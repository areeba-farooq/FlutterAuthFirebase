import 'package:authentication_firebase/Pages/forgotpassword_auth.dart';
import 'package:authentication_firebase/Pages/signup_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_auth.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
  }

  userLogin() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeAuth()));
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No user found with that email address', style: TextStyle(color: Colors.white, fontFamily: 'Karla-Medium', fontSize: 18 ),)));
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong password provided by the user.', style: TextStyle(color: Colors.white, fontFamily: 'Karla-Medium', fontSize: 18 ),)));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                children: [
                  Center(child: Image.asset('assets/login.png', width: 350, height: 350,)),
                  const Positioned(
                    top: 50,
                      right: 0,
                      left: 70,
                      bottom: 0,
                      child: Text('Login', style: TextStyle(fontSize: 40, fontFamily: 'FiraSans', color:  Color(0xFFF9A826), letterSpacing: 0.7),)),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter email address';
                    } else if (!value.contains('@')){
                      return 'Please enter Valid Email Adress';
                    }else{
                      return null;
                    }
                  },
                  decoration:  const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))
                      ),
                      errorStyle: TextStyle(fontSize: 15)

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
              }, child: const Text('Forgot Password?', style: TextStyle(fontSize: 15, fontFamily: 'Karla-Medium'),)),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });
                  userLogin();
                }
              }, child: const Text('Login', style: TextStyle(
                  color: Colors.black, fontSize: 20
              ),),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF9A826),
                    fixedSize: const Size(150,50)
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUp()));
                },
                child: RichText(
                  text: const TextSpan(text: "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Karla-Medium'),
                  children: [ TextSpan(text: '  Signup', style: TextStyle(
                    color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: 'Karla-Medium'
                  ))]
                  ),
                ),
              )

              
            ],
          ),
        ),
      ),

    );
  }
}
