import 'package:authentication_firebase/Pages/login_auth.dart';
import 'package:authentication_firebase/Pages/signup_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //clean up the controller when the widget is disposed.
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Center(child: Image.asset('assets/forgot.png', width: 350, height: 350,)),
              const Text('Reset password link will be send to your Email Address',textAlign: TextAlign.center, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Karla-Medium',
                fontSize: 18,
              ),),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter email address';
                    } else if (value.contains('@')){
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
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    email = emailController.text;
                  });
                }
              }, child: const Text('Send Code', style: TextStyle(
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
                  text: const TextSpan(text: "Don't have an account",
                      style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Karla-Medium'),
                      children: [ TextSpan(text: '  SignUp', style: TextStyle(
                          color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: 'Karla-Medium'
                      ))]
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
              }, child: const Icon(Icons.arrow_back),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF9A826),
                  fixedSize: const Size(50,50)
              ),
              )


            ],
          ),
        ),
      ),

    );
  }
}
