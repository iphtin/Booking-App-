import 'package:barber_booking_app/Admin/booking_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller= new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  

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
          child: Text("Admin\nPanel!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),),
          ),
         SingleChildScrollView(
           child: Container(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              )
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text("Username", style: TextStyle(
                color: Color(0xFFB91635),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),),
              TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  hintText: "Username",
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
                  loginAdmin();
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
                    child: Text("LogIn", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),),
                  ),
                ),
              ),
              ],),
            ),
           ),
         )
       ],),),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if(result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Username is not Admin", style: TextStyle(fontSize: 20.0),)));
        }
        else if(result.data()['password'] != passwordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong password!", style: TextStyle(fontSize: 20.0),)));
        }

        else  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingAdmin()));
        }
      });
    });
  }
}