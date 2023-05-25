import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tubes_provis/class/checkout.dart';
import 'class/currencyFormat.dart';
import 'class/produk.dart';
import 'package:tubes_provis/controllers/cartController.dart';
import 'main.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});
  @override
  State<Checkout> createState() => _CheckoutState();
}

class items {
  String produk;
  String ukuranwarna;
  int harga;

  items({required this.produk, required this.ukuranwarna, required this.harga});
}

class _CheckoutState extends State<Checkout> {
  final CartController controller = Get.find();
  final user = FirebaseAuth.instance.currentUser!;
  Future createdata(List<Produk> product) async {
    List<Produk> data = [];
    final upload = FirebaseFirestore.instance.collection('checkout').doc();
    for (Produk item in product) {
      final checkout = Produk(
        deskripsi: item.deskripsi,
        gambar: item.gambar,
        harga: item.harga,
        namaProduk: item.namaProduk,
        rating: item.rating,
        reviews: item.reviews,
        selled: item.selled,
        quantity: item.quantity,
        check: item.check,
      );
      data.add(checkout);
    }
    var test = data.map((e) {
      return {
        "nama Produk": e.namaProduk,
        "Harga Produk": e.harga,
        "Jumlah Produk": e.quantity,
        "Gambar Produk": e.gambar
      };
    }).toList();
    final checkoutFinal = checkout(
        produk: test,
        uid: user.uid,
        timestamp: DateTime.now(),
        totalharga: double.parse(controller.total));

    final json = checkoutFinal.toJson();
    await upload.set(json);
  }

  int _counter = 0;
  String tampilanAwalDrop = "Bank BDA";
  String tampilanakhirDrop = "";
  List<items> data = [
    items(produk: "Produk 1", ukuranwarna: "Ukuran & Warna", harga: 20),
    items(produk: "Produk 2", ukuranwarna: "Ukuran & Warna2", harga: 30),
  ];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> metode = [];
    var pilihan1 = const DropdownMenuItem<String>(
      value: "Bank BDA",
      child: Text("Bank BDA"),
    );
    var pilihan2 = const DropdownMenuItem<String>(
      value: "Bank BWI",
      child: Text("Bank BWI"),
    );
    var pilihan3 = const DropdownMenuItem<String>(
      value: "Bank BBJ",
      child: Text("Bank BBJ"),
    );
    metode.add(pilihan1);
    metode.add(pilihan2);
    metode.add(pilihan3);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 25),
            alignment: Alignment.center,
            child: Text(
              "Order Summary",
              style: GoogleFonts.inter(
                  color: Colors.black, textStyle: TextStyle(fontSize: 24)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.only(bottom: 15),
            margin: EdgeInsets.only(left: 25),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromRGBO(220, 220, 220, 1.0)),
              ),
            ),
            child: Text(
              "Items",
              style: GoogleFonts.inter(
                  color: Color.fromRGBO(134, 134, 134, 1.0),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: controller.productCheck.length,
              itemBuilder: (context, int index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 25, bottom: 8, top: 8),
                            child: Text(
                              "${controller.productCheck[index].namaProduk}",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  textStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Text(
                              "Test doang",
                              style: GoogleFonts.inter(
                                  color: Color.fromRGBO(134, 134, 134, 1.0),
                                  textStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "${CurrencyFormat.format(2, controller.productCheck[index].harga * controller.productCheck[index].quantity)}",
                          style: GoogleFonts.inter(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(left: 25, top: 15, bottom: 15),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color.fromRGBO(220, 220, 220, 1.0)),
              ),
            ),
            child: Text(
              "Address",
              style: GoogleFonts.inter(
                  color: Color.fromRGBO(134, 134, 134, 1.0),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              onChanged: (text) {},
              decoration: InputDecoration(
                labelText: 'Masukkan Alamat',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 25),
            child: Text(
              "Payment Method",
              style: GoogleFonts.inter(
                  color: Color.fromRGBO(134, 134, 134, 1.0),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: DropdownButton(
              value: tampilanAwalDrop,
              items: metode,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != null) {
                    tampilanAwalDrop = newValue;
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Shipping Cost",
                  style: GoogleFonts.inter(
                      color: Color.fromRGBO(134, 134, 134, 1.0),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                margin: EdgeInsets.only(left: 25),
              ),
              Container(
                child: Text(
                  "Free",
                  style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                margin: EdgeInsets.only(right: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Total",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                margin: EdgeInsets.only(left: 25),
              ),
              Container(
                child: Text(
                  "${CurrencyFormat.format(2, double.parse(controller.total))}",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                margin: EdgeInsets.only(right: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                    controller.productCheck.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    elevation: 0.0,
                    primary: const Color(0xFF1D1D1B),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black45)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                    controller.delete();
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    elevation: 0.0,
                    primary: const Color(0xFF1D1D1B),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black45)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
