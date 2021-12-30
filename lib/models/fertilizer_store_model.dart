import 'package:cloud_firestore/cloud_firestore.dart';

class FertilizerStoreModel {
  final String? name;
  final String? address;
  final String? phone;
  final GeoPoint? position;

  FertilizerStoreModel({this.name, this.address, this.phone, this.position});

  factory FertilizerStoreModel.fromJson(Map<String, dynamic> json) => FertilizerStoreModel(
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
    position: json['position']
  );
}