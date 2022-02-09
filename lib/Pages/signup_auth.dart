import 'package:authentication_firebase/Pages/home_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String userName = '';
  bool isHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
  }

  registration() async {
//first we check password and confirm password should be matched
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (kDebugMode) {
          print(userCredential);
        }
         // user!.displayName;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0xFF73b504),
            content: Text(
              'Registered Successfully!',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Karla-Medium',
                  fontSize: 18),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'week-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Provided password is too week!',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Karla-Medium',
                    fontSize: 18),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Account already exists with this email address!',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Karla-Medium',
                    fontSize: 18),
              )));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Password and confirm Password doesn't match",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Karla-Medium', fontSize: 18),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Center(
                      child: Image.asset(
                    'assets/signup.png',
                    width: 350,
                    height: 350,
                  )),
                  const Positioned(
                      top: 50,
                      right: 0,
                      left: 150,
                      bottom: 0,
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'FiraSans',
                            color: Color(0xFFF9A826),
                            letterSpacing: 0.7),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  controller: userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter User Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'UserName',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      errorStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
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
                          color: Colors.black,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      errorStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  autofocus: false,
                  obscureText: isHidden,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length <= 8) {
                      return 'Password should be 8 characters long';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      errorStyle: const TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: Icon(
                              isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFFF9A826)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: TextFormField(
                  autofocus: false,
                  obscureText: isHidden,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length <= 8) {
                      return 'Password should be 8 characters long';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Karla-Bold'),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9A826))),
                      errorStyle: const TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: Icon(
                              isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFFF9A826)))),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                      confirmPassword = confirmPasswordController.text;
                      userName = userNameController.text;
                    });
                    registration();
                  }
                },
                child: const Text(
                  'SingUp',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF9A826),
                    fixedSize: const Size(150, 50)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: RichText(
                  text: const TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Karla-Medium'),
                      children: [
                        TextSpan(
                            text: '  Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Karla-Medium'))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
