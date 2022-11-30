import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String? place_id;
  String? bloc_id;
  double? latitude;
  double? longitude;
  bool? status;

  PlaceModel({
    this.place_id,
    this.bloc_id,
    this.status = true,
    this.latitude = 6.900001,
    this.longitude = 7.9827401,
  });

  // receiving data from server
  factory PlaceModel.fromMap(map) {
    return PlaceModel(
        place_id: map['place_id'],
        bloc_id: map['bloc_id'],
        status: map['status'],);

    //latitude: map['latitude'],
    //longitude: map['longitude']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'place_id': place_id,
      'bloc_id': bloc_id,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Map<String, dynamic> toJson() => {
    'place_id': place_id,
    'bloc_id': bloc_id,
    'status': status,
    //'latitude':latitude,
    //'longitude':longitude
  };
  static PlaceModel fromJson(Map<String, dynamic> json) => PlaceModel(
    place_id: json['place_id'],
    bloc_id: json['bloc_id'],
    status: json['status'],

    //latitude: json['latitude'],
    //longitude: json['longitude']
  );
/*  TripModel.fromSnapshot(snapshot)
      : trip_id = snapshot.data()['trip_id'],
        uid = snapshot.data()['uid'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        source = snapshot.data()['source'],
        destination = snapshot.data()['destination'],
        vehicule_type = snapshot.data()['type'],
        weight = snapshot.data()['weight'],
        price = snapshot.data()['price'],
        date = snapshot.data()['date'].toDate();*/
//latitude=snapshot.data()['latitude'],
//longitude=snapshot.data()['longitude'];

}