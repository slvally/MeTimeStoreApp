import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class/produk.dart';
import 'controllers/cartController.dart';
import 'class/currencyFormat.dart';

class ViewProductPage extends StatefulWidget {
  ViewProductPage({
    super.key,
    required this.listproduk,
  });
  Produk listproduk;
  @override
  State<ViewProductPage> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProductPage> {
  final cartTest = Get.put(CartController());

  void writeNewPost(String uid, String username, String picture, String title,
      String body) async {
    // A post entry.
    final postData = {
      'author': username,
      'uid': uid,
      'body': body,
      'title': title,
      'starCount': 0,
      'authorPic': picture,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Product',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 32, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 
                  Product name
              */
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "${widget.listproduk.namaProduk}",
                  style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 24)),
                ),
              ),

              /* 
                  Product Image
              */
              SizedBox(
                height: 10,
              ),
              Container(
                child: Card(
                  // elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.listproduk.gambar,
                                ),
                                fit: BoxFit.contain)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              /* 
                  Detail Product
              */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "${widget.listproduk.rating}",
                        style: GoogleFonts.inter(
                            color: Color.fromRGBO(134, 134, 134, 1.0)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("${widget.listproduk.reviews} Reviews",
                          style: GoogleFonts.inter(
                              color: Color.fromRGBO(20, 170, 255, 1.0))),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("${widget.listproduk.selled} Selled",
                        style: GoogleFonts.inter(
                            color: Color.fromRGBO(134, 134, 134, 1.0))),
                  ),
                ],
              ),

              /* 
                  Deskription Product
              */
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  widget.listproduk.deskripsi.replaceAll("\\n", "\n"),
                  style: GoogleFonts.inter(
                      color: Color.fromRGBO(134, 134, 134, 1.0)),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              /* 
                  Price Product
              */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '${CurrencyFormat.format(2, widget.listproduk.harga.toDouble())}',
                      style: GoogleFonts.inter(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              /* 
                  Add to Cart
              */
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    cartTest.increment(widget.listproduk);
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    elevation: 0.0,
                    primary: const Color(0xFF1D1D1B),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: const BorderSide(color: Colors.black45)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Add Item to Cart",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
