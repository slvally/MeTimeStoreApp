import 'package:cloud_firestore/cloud_firestore.dart';

class checkout {
  DateTime timestamp;
  String uid;
  List produk;
  double totalharga;
  checkout(
      {required this.produk,
      required this.uid,
      required this.timestamp,
      required this.totalharga});
  factory checkout.fromJson(Map<String, dynamic> json) => checkout(
        timestamp: json["timestamp"],
        uid: json["uid"],
        produk: json["produk"],
        totalharga: json["totalharga"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "uid": uid,
        "produk": produk,
        "totalharga": totalharga,
      };
}
