import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future adduserDetails(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .set(userInfoMap);
  }

  Future adduserBooking(Map<String, dynamic> userBookMap) async {
    await FirebaseFirestore.instance
    .collection("Booking")
    .add(userBookMap);
  }

  Future<Stream<QuerySnapshot>> getBookings() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }

   DeletedBookings(String id) async {
    await FirebaseFirestore.instance
    .collection("Booking")
    .doc(id).delete();
  }

}