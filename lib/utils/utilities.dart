import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utilities {
  static Future<void> openWhatsapp(String phone) async {
    var text = "Hai apakah pupuk di toko anda masih tersedia ?";
    var whatsappURl = "whatsapp://send?phone=$phone&text=$text";
    await launch(whatsappURl);
  }

  static String readTimeStamp(Timestamp timestamp) {
    DateTime time = DateTime.parse(timestamp.toDate().toString());
    var format = DateFormat.Hm();
    return format.format(time);
  }
}