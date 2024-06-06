import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/login.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String? name, email, password;

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  registration() async {
    if(password!=null && email!=null && name!=null) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        String id = randomAlphaNumeric(10);
        await SharedpreferencesHelper().saveUserName(namecontroller.text);
        await SharedpreferencesHelper().saveUserEmail(emailcontroller.text);
        await SharedpreferencesHelper().saveUserImage("https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/o80ZMwgIhyzEjQVfIDCuAyBOPAlB2eAAEg2Qtq~tplv-tej9nj120t-origin.webp");
        await SharedpreferencesHelper().saveUserId(id);
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "email": emailcontroller.text,
          "id": id,
          "image": "https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/o80ZMwgIhyzEjQVfIDCuAyBOPAlB2eAAEg2Qtq~tplv-tej9nj120t-origin.webp"
        };
       await DatabaseMethods().adduserDetails(userInfoMap, id);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0),)));
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch(e) {
        if(e.code=='weak-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password provided too weak!", style: TextStyle(fontSize: 20.0),)));
        }else if(e.code == "email-already") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account already exist", style: TextStyle(fontSize: 20.0),))); 
        }
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
          child: Text("Create Your\nAccount!", style: TextStyle(
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
               Text("Name", style: TextStyle(
                color: Color(0xFFB91635),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),),
              TextFormField(
                validator: (value) {
                  if(value == null || value.isEmpty)  {
                    return "Please Enter Your Name";
                  }
                  return null;
                },
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(Icons.person_2_outlined)
                ),
              ),
              SizedBox(height: 30,),
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
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () {
                  if(_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailcontroller.text;
                      name = namecontroller.text;
                      password = passwordcontroller.text;
                    });
                  }
                  registration();
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
                    child: Text("CREATE ACCOUNT", style: TextStyle(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account", style: TextStyle(
                          color: Color(0xFF311937),
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        ),),
                    SizedBox(width: 4,),
                    Text("Sign in", style: TextStyle(
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