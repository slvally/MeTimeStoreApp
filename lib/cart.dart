import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'class/currencyFormat.dart';
import 'class/produk.dart';
import 'package:tubes_provis/controllers/cartController.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartState();
}

class _CartState extends State<CartPage> {
  final CartController controller = Get.find();
  bool isChecked = false;

  Widget getItem(List<Produk> product) {
    int barang = 0;
    int harga = 0;
    for (Produk item in product) {
      if (item.check) {
        barang++;
        harga += (item.harga * item.quantity);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Harga (${barang} Barang)",
          style: GoogleFonts.inter(
              color: Color.fromRGBO(134, 134, 134, 1.0),
              textStyle: TextStyle(fontSize: 16)),
        ),
        Text(
          "${CurrencyFormat.format(2, harga.toDouble())}",
          style: GoogleFonts.inter(
              color: Colors.black, textStyle: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          minimum: const EdgeInsets.only(top: 21),
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 70),
                      itemCount: controller.products2.length,
                      itemBuilder: (context, int index) {
                        return Card(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 195,
                              child: Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            controller.products2[index].gambar,
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.products2[index]
                                                    .namaProduk,
                                                style: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    textStyle: TextStyle(
                                                        fontSize: 20)),
                                              ),
                                              Text(
                                                "Rp. ${controller.products2[index].harga}",
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 18)),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        top: BorderSide(
                                            color: Color.fromRGBO(
                                                220, 220, 220, 1.0)),
                                      )),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  value: controller
                                                      .products2[index].check,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      controller
                                                          .products2[index]
                                                          .check = value!;
                                                      print(controller
                                                          .products2[index]
                                                          .check);
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      primary: Colors.black,
                                                      minimumSize: Size(0, 0),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0)),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (controller
                                                              .products2[index]
                                                              .quantity >
                                                          1)
                                                        controller
                                                            .products2[index]
                                                            .quantity--;
                                                    });
                                                  },
                                                  child: Icon(
                                                      Icons.arrow_back_ios),
                                                ),
                                                Text(
                                                    "${controller.products2[index].quantity}"),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      primary: Colors.black,
                                                      minimumSize: Size(0, 0),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0)),
                                                  onPressed: () {
                                                    setState(() {
                                                      controller
                                                          .products2[index]
                                                          .quantity++;
                                                    });
                                                  },
                                                  child: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "${CurrencyFormat.format(2, controller.products2[index].harga * controller.products2[index].quantity)}"),
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                        );
                      })),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 0,
                child: Card(
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getItem(controller.products2),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(20),
                              backgroundColor: controller.productCheck.isEmpty
                                  ? null
                                  : Colors.lightBlueAccent,
                            ),
                            onPressed: controller.productCheck.isEmpty
                                ? null
                                : () {
                                    Navigator.pushNamed(context, '/checkout');
                                  },
                            child: Text("Checkout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class cartItems {
  String produk;
  String image;
  int harga;
  int qty;
  bool check = false;

  cartItems(
      {required this.produk,
      required this.image,
      required this.harga,
      required this.qty});
}
