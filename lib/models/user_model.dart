import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? address;
  final String? user;
  final String? whatsapp;
  final GeoPoint? position;

  UserModel({this.id,this.name, this.address, this.user, this.whatsapp, this.position});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
    name: json['name'],
    address: json['address'],
    user: json['user'],
    whatsapp: json['whatsapp'],
    position: json['position']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'user': user,
    'whatsapp': whatsapp,
    'position': position,
  };
}