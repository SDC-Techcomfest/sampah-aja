import 'package:cloud_firestore/cloud_firestore.dart';

class GuestModel {
  final String? id;
  final String? name;
  final String? whatsapp;
  final String? address;
  final GeoPoint? position;

  GuestModel({this.id, this.name, this.whatsapp, this.address, this.position});

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
      id: json['id'],
      name: json['name'],
      whatsapp: json['whatsapp'],
      address: json['address'],
      position: json['position']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'whatsapp': whatsapp,
    'address': address,
    'position': position,
  };
}