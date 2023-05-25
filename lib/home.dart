import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'class/currencyFormat.dart';
import 'class/produk.dart';
import 'viewproduk.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<String> gambar = [];
  List<Produk> listproduk = [];
  void initState() {
    super.initState();
  }

  var kMobileBreakpoint = 576;
  var kTabletBreakpoint = 1024;
  var kDesktopBreakPoint = 1366;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("produk").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var _list = snapshot.data!.docs
              .map((item) => Produk(
                    deskripsi: item['deskripsi'],
                    gambar: item['gambar'],
                    harga: item['harga'],
                    namaProduk: item['nama_produk'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                    selled: item['selled'],
                    quantity: item["quantity"],
                    check: item["check"],
                  ))
              .toList();
          listproduk = _list;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                          Promo Hot
                      */
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Promo Hot',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                      CustomCard(
                          title: "${listproduk[0].namaProduk}",
                          image: listproduk[0].gambar),

                      /*
                          Special Today
                      */
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Special Today',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "https://asset-3s.3second.co.id/p/product/215062115CK_2.JPG",
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Khusus Buat Kamu',
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                ],
                              ),
                            ), //Container
                          ), //Flexible
                          SizedBox(
                            width: 10,
                          ), //SizedBox
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "https://asset-3s.3second.co.id/p/product/905062215HT_3.JPG",
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Terfavorit Minggu Ini',
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                ],
                              ),
                            ), //Container
                          ) //Flexible
                        ], //<Widget>[]
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),

                      /*
                          Catalog
                      */
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Catalog',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, dimens) {
                          if (dimens.maxWidth <= kMobileBreakpoint) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 264,
                              ),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: listproduk.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  child: CustomCardCatalog(
                                      title: listproduk[index].namaProduk,
                                      image: listproduk[index].gambar,
                                      price: listproduk[index].harga,
                                      fontSizeTitle: 14,
                                      fontSizePrice: 10,
                                      heightImg: 150),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewProductPage(
                                          listproduk: listproduk[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else if (dimens.maxWidth > kMobileBreakpoint &&
                              dimens.maxWidth <= kTabletBreakpoint) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 264,
                              ),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: listproduk.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  child: CustomCardCatalog(
                                      title: listproduk[index].namaProduk,
                                      image: listproduk[index].gambar,
                                      price: listproduk[index].harga,
                                      fontSizeTitle: 14,
                                      fontSizePrice: 10,
                                      heightImg: 150),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewProductPage(
                                          listproduk: listproduk[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else if (dimens.maxWidth > kTabletBreakpoint &&
                              dimens.maxWidth <= kDesktopBreakPoint) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 280,
                              ),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: listproduk.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  child: CustomCardCatalog(
                                      title: listproduk[index].namaProduk,
                                      image: listproduk[index].gambar,
                                      price: listproduk[index].harga,
                                      fontSizeTitle: 16,
                                      fontSizePrice: 14,
                                      heightImg: 150),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewProductPage(
                                          listproduk: listproduk[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 280,
                              ),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: listproduk.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  child: CustomCardCatalog(
                                      title: listproduk[index].namaProduk,
                                      image: listproduk[index].gambar,
                                      price: listproduk[index].harga,
                                      fontSizeTitle: 16,
                                      fontSizePrice: 14,
                                      heightImg: 180),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewProductPage(
                                          listproduk: listproduk[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CustomCard extends StatelessWidget {
  //ini adalah konstruktor, saat class dipanggil parameter konstruktor wajib diisi
  //parameter ini akan mengisi title dan gambar pada setiap card
  CustomCard({required this.title, required this.image});

  String title;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.contain)),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCardCatalog extends StatelessWidget {
  //ini adalah konstruktor, saat class dipanggil parameter konstruktor wajib diisi
  //parameter ini akan mengisi title dan gambar pada setiap card
  CustomCardCatalog(
      {required this.title,
      required this.image,
      required this.price,
      required this.fontSizeTitle,
      required this.fontSizePrice,
      required this.heightImg});

  String title;
  String image;
  int price;
  double fontSizeTitle;
  double fontSizePrice;
  double heightImg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: SizedBox(
                height: heightImg,
                child: Expanded(
                  child: Image.network(image, fit: BoxFit.contain),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${CurrencyFormat.format(2, price.toDouble())}',
                  style: TextStyle(
                      fontSize: fontSizePrice,
                      fontWeight: FontWeight.normal,
                      color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
