import 'package:barber_booking_app/pages/forgot_password.dart';
import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch(e) {
      if(e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user Found for that Email", style: TextStyle(fontSize: 18.0, color: Colors.red),)));
      }else if(e.code == 'wrong-password') {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong passwor!", style: TextStyle(fontSize: 18.0, color: Colors.red),)));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(child: Stack(children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20),
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFB91635),
                Color(0xFF621d3c),
                Color(0xFF311937)
              ])
            ),
          child: Text("Hello\nSign in!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),),
          ),
         SingleChildScrollView(
           child: Container(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              )
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Gmail", style: TextStyle(
                color: Color(0xFFB91635),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),),
              TextFormField(
                validator: (value) {
                    if(value == null || value.isEmpty)  {
                      return "Please Enter Your Email";
                    }
                    return null;
                  },
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: "Gmail",
                  prefixIcon: Icon(Icons.mail_outline)
                ),
              ),
              SizedBox(height: 30,),
              Text("Password", style: TextStyle(
                color: Color(0xFFB91635),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),),
              TextFormField(
                validator: (value) {
                    if(value == null || value.isEmpty)  {
                      return "Please Enter Your Password";
                    }
                    return null;
                  },
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password_outlined)
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: Text("Forgot Password?", style: TextStyle(
                      color: Color(0xFF311937),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () {
                   if(_formKey.currentState!.validate()) {
                     setState(() {
                       email = emailcontroller.text;
                       password = passwordcontroller.text;
                     });
                   }
                  userLogin();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFB91635),
                      Color(0xFF621d3c),
                      Color(0xFF311937)
                    ]),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(
                    child: Text("SIGN IN", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account", style: TextStyle(
                          color: Color(0xFF311937),
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        ),),
                    SizedBox(width: 4,),
                    Text("Register", style: TextStyle(
                      color: Color(0xFF621d3c),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                  ],
                ),
              )
              ],),
            ),
           ),
         )
       ],),),
    );
  }
}