import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverModel {
  String? uid;
  String? email;
  String? Name;
  int? phone;

  DriverModel({this.uid, this.email, this.Name, this.phone});

  // receiving data from server
  factory DriverModel.fromMap(map) {
    return DriverModel(
      uid: map['uid'],
      email: map['email'],
      Name: map['firstName'],
      phone: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': Name,
      'phone':phone,
    };
  }
  static DriverModel fromJson(Map<String, dynamic> json) => DriverModel(
    uid: json['uid'],
    email: json['email'],
    Name: json['firstName'],
    phone: json['phone'],
  );


}