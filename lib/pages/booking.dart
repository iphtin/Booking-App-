import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bookinag extends StatefulWidget {
  final category;
  const Bookinag({super.key, required this.category});

  @override
  State<Bookinag> createState() => _BookinagState();
}

class _BookinagState extends State<Bookinag> {
    String? name, image, email;

  getthedatafromsharedpref() async {
    name = await SharedpreferencesHelper().getUserName();
    image = await SharedpreferencesHelper().getUserImage();
    email = await SharedpreferencesHelper().getUserEmail();
    setState(() {
      
    });
  }

  getontheload() async {
    await getthedatafromsharedpref();
    setState(() {
      
    });
  } 

  @override
  void initState() {
    getontheload();
    super.initState();
  }
  
   DateTime _selectedDate = DateTime.now();

   Future<void> _selectData(BuildContext context) async {
      final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2024), lastDate: DateTime(2025));
      if(picked!= null && picked!= _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
   }

   TimeOfDay _selectedTime = TimeOfDay.now();

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _selectedTime);
      if(picked!= null && picked!= _selectedTime) {
        setState(() {
          _selectedTime = picked;
        });
      }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.only(left: 10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          GestureDetector(  
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0,),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30,),
            )),
          SizedBox(height: 30,),
          Text("Lets's the\njourney begin", style: TextStyle(
            color: Colors.white70,
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset("images/discount.png")
            ),
          SizedBox(height: 20,),
           Text(widget.category, style: TextStyle(
            color: Colors.white70,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 67, 46, 46),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text("Set a Date", style: TextStyle(
                  color: Colors.white24,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectData(context);
                      },
                      child: Icon(Icons.calendar_month, color: Colors.white, size: 30,)),
                    SizedBox(width: 20,),
                    Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}", style: TextStyle(
                      color: Colors.white,
                      fontSize: 26, 
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 67, 46, 46),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text("Set a Time", style: TextStyle(
                  color: Colors.white24,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Icon(Icons.alarm, color: Colors.white, size: 30,)),
                    SizedBox(width: 20,),
                    Text(_selectedTime.format(context), style: TextStyle(
                      color: Colors.white,
                      fontSize: 26, 
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ],
            ),
          ), 
        SizedBox(height: 30,),
        GestureDetector(
          onTap: () async {
            Map<String, dynamic> userBookMap = {
              "Service": widget.category,
              "Date": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}".toString(),
              "Time":  _selectedTime.format(context).toString(), 
              "username": name,
              "Image": image,
              "Email": email
            };
            await DatabaseMethods().adduserBooking(userBookMap).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Service has been booked Successfully!", style: TextStyle(fontSize: 16.0),)));
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFfe8f33),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text("Book Now", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
        )
        ],),
      ),
    );
  }
}