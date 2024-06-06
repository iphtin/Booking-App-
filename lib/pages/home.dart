import 'package:barber_booking_app/pages/booking.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name, image;

  getthedatafromsharedpref() async {
    name = await SharedpreferencesHelper().getUserName();
    image = await SharedpreferencesHelper().getUserImage();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello", style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 242, 242, 242), fontWeight: FontWeight.w300),),
                if (name != null)
                Text(name!, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),)
              ],
            ),
          if (image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image!, height: 60, width: 60, fit: BoxFit.cover,))
          ],),
          SizedBox(height: 20,),
          Divider(color: Colors.white38,),
          SizedBox(height: 20,),
          Text("Services", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
          SizedBox(height: 20,),
          ServicesWidget(serviceImage: "images/shaving.png",
           title: "Classic Shaving",
           title2: "Hair Washing",
           serviceImage2: "images/hair.png",
           ),
          SizedBox(height: 10,),
          ServicesWidget(serviceImage: "images/cutting.png",
           title: "Hair Cutting",
           title2: "Beard Trimming",
           serviceImage2: "images/beard.png",
           ),
          SizedBox(height: 10,),
          ServicesWidget(serviceImage: "images/facials.png",
           title: "Facials",
           title2: "Kids HairCutting",
           serviceImage2: "images/kids.png",
           ),
        ],),
      ),
    );
  }
}

class ServicesWidget extends StatelessWidget {
  final String title;
  final String serviceImage;
  final String title2;
  final String serviceImage2;
  const ServicesWidget({
    super.key,
    required this.serviceImage,
    required this.title,
    required this.serviceImage2,
    required this.title2
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: GestureDetector(
           onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bookinag(category: title,)));
            },
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 40, 20),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Image.asset(serviceImage, height: 98, width: 80, fit: BoxFit.cover,),
                   Text(title, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ),
         SizedBox(width: 10.0,),
        Flexible(
          fit: FlexFit.tight,
          child: GestureDetector(
           onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bookinag(category: title2,)));
            },
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 40, 20),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Image.asset(serviceImage2, height: 98, width: 80, fit: BoxFit.cover,),
                   Text(title2, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}