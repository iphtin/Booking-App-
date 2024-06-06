import 'package:barber_booking_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {

  Stream? BookingStream;

  getontheload() async {
    BookingStream = await DatabaseMethods().getBookings();
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allBookings () {
    return StreamBuilder(stream: BookingStream, builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  Material(
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                        Color(0xFFB91635),
                        Color(0xFF621d3c),
                        Color(0xFF311937)
                      ]),
              borderRadius: BorderRadius.circular(5) 
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(ds['Image'], height: 80, width: 80, fit: BoxFit.cover,)),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ds['username'], style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        Text(ds['Email'], style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white60
                        ),),
                      ],
                    )
                ],
              ),
              SizedBox(height: 20,),
              Text("Service: ${ds['Service']}", style: 
              TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Date: ${ds['Date']}", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
               ),),
              SizedBox(height: 10,),
              Text("Time:${ds['Time']}", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
               ),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  await DatabaseMethods().DeletedBookings(ds.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFdf711a),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Done", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                   ),),
                ),
              ),
              SizedBox(height: 20,),
            ]),
          ),
        );
        }) : Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(children: [
        Center(child: Text("All Bookings", style:
         TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)),
        SizedBox(height: 20,),
        Expanded(child: allBookings ()),
      ],),),
    );
  }
}