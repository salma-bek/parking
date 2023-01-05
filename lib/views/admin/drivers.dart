import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/views/admin/add_driver.dart';

class Drivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current Drivers',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              /*onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(),
                  ),
                );
              },*/
              child: TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddDriver())),
                child: Text(
                  'Add New Driver',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}