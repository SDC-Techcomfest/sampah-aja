import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String? title;
  final String? whatsapp;
  final String? address;
  final String? from;
  final String? to;
  final int? garbageSize;
  final Timestamp? time;
  final GeoPoint? position;

  NotificationModel({this.id, this.title, this.address, this.from,this.garbageSize, this.whatsapp,this.to, this.time, this.position});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'],
      title: json['title'],
      to: json['to'],
      garbageSize: json['garbageSize'],
      whatsapp: json['whatsapp'],
      address: json['address'],
      time: json['time'],
      from:json['from'],
      position: json['position']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'time': time,
    'to': to,
    'garbageSize': garbageSize,
    'from': from,
    'address': address,
    'whatsapp': whatsapp,
    'position': position,
  };
}