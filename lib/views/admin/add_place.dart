import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:location/location.dart' as loc;
import 'package:smart_parking/views/admin/home.dart';

import '../../models/place.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  bool isBreakable = false;
  TextEditingController place_idController = TextEditingController();
  TextEditingController bloc_idController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool status = false;

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Add Place",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    controller: place_idController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Place ID';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Place ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                SizedBox(height: 20),
                TextFormField(
                    controller: bloc_idController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Bloc ID';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Bloc ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Checkbox(
                              value: status,
                              onChanged: (bool? value) {
                                setState(() {
                                  status = value!;
                                  print(status);
                                });
                              },
                            ),
                            Text(
                              'Status',
                              style: new TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                //    SizedBox(height: 20),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      _getLocation();
                    },
                    child: Text('Add my location')),
                SizedBox(height: 20),
                !isLoading
                    ? Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),

                                // side: BorderSide(color: Theme.of(context).colorScheme.primary)
                              )),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary)),
                      onPressed: (() async {
                        if (_formKey.currentState!.validate()) {
                          DatabaseService service = DatabaseService();
                          PlaceModel trip = PlaceModel(
                            place_id: place_idController.text,
                            bloc_id: bloc_idController.text,
                            status: status,
                          );
                          setState(() {
                            isLoading = true;
                          });
                          await service.addPlace(trip);
                          Navigator.pushAndRemoveUntil(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeAdmin()),
                                  (route) => false);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      )),
                )
                    : const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),

            ),
          ),
        ),
    );
  }
  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection("places").doc(place_idController.text).update({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude
      });
    } catch (e) {
      print(e);
    }
  }
}


class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  addPlace(PlaceModel placeData) async {
    var doc_ref = await _db.collection("places").add(placeData.toMap());
    var documentID = doc_ref.id;
    _db
        .collection("places")
        .doc(documentID)
        .update({"places": documentID})

        .then((_) => print("Successful update"))
        .catchError((error) => print("Failed: $error"));


  }


  updatePlace(PlaceModel tripData, String docId) async {
    await _db
        .collection("places")
        .doc(docId)
        .update({
      "bloc_id": tripData.bloc_id,
      "status": tripData.status,
      "longitude": tripData.longitude,
      "latitude": tripData.latitude,
    })
        .then((_) => print('Successful update'))
        .catchError((error) => print('Failed: $error'));
  }

}