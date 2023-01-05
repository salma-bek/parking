import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int numberOfTrips = 0;
  int numberOfRequests = 0;

  @override
  void initState() {
    super.initState();

    getTotalTrips();
    getTotalRequests();
    getTotalEarnings();
  }

  void getTotalTrips() async {
    await FirebaseFirestore.instance
        .collection('trips')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
      numberOfTrips += 1;
    }));
    setState(() {});
  }

  void getTotalRequests() async {
    await FirebaseFirestore.instance
        .collection('requests')
        .where('tripOwner', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
      numberOfRequests += 1;
    }));
    setState(() {});
  }

  int earning=0;

  void getTotalEarnings() async {
    DocumentSnapshot snap = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    earning = snap['earning'];
  }

  int rate=0;

  void getRate() async {
    DocumentSnapshot snap = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    rate = snap['rate'].toInt();
  }

  @override
  Widget build(BuildContext context) {
    getTotalEarnings();
    getRate();
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        // color: kPrimaryColor.withOpacity(0.03),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: <Widget>[
          /*InfoCard(
            title: "Rating",
            iconColor: Color(0xFFFF8C00),
            effectedNum: rate,
            // press: () {},
          ),*/
          /*GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(
                    builder: (context) =>
                        AllTripsCarrier()),
                    (route) => false),
            child: InfoCard(
              title: "Total Trips",
              iconColor: Color(0xFFFF2D55),
              effectedNum: numberOfTrips,
              // press: () {},
            ),
          ),*/
          /*GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(
                    builder: (context) =>
                        Earning()),
                    (route) => false),
            child:InfoCard(
              title: "Average Earnings",
              iconColor: Color(0xFF50E3C2),
              effectedNum: earning,
              //  press: () {},
            ),
          ),*/
          /*GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(
                    builder: (context) =>
                        CarrierCustomBottomNavigationBar(index: 2)),
                    (route) => false),
            child: InfoCard(
              title: "Total Requests",
              iconColor: Color(0xFF5856D6),
              effectedNum: numberOfRequests,
            ),
          ),*/
        ],
      ),
    );
  }
}