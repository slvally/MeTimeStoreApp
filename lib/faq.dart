import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => FaqState();
}

class FaqState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'FAQ',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Row(
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.arrow_left),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/dashboard');
                //       },
                //     ),
                //     Container(
                //       decoration:
                //           BoxDecoration(border: Border.all(color: Colors.blue)),
                //       margin: EdgeInsets.only(top: 18, bottom: 18),
                //       child: Text(
                //         "FAQ",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 32,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //   ],
                // ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    // margin: EdgeInsets.only(bottom: 32, top: 32),
                    // decoration:
                    // BoxDecoration(border: Border.all(color: Colors.black)),
                    // width: Get.width * 0.4,
                    // height: Get.height * 0.6,
                    child: Image.asset(
                      "FAQ.jpg",
                      height: 250.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Card1(
                    judul: "Bagaimana Saya Memesan Produk di Aplikasi MeTime?",
                    isi:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue finibus tellus eget tempus. Ut orci nunc, fringilla eget fringilla semper, consequat non felis. Donec suscipit orci at dolor porttitor.",
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                Container(
                  child: Card1(
                    judul: "Bagaimana Saya Mengajukan Refund Item?",
                    isi:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue finibus tellus eget tempus. Ut orci nunc, fringilla eget fringilla semper, consequat non felis. Donec suscipit orci at dolor porttitor.",
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                Container(
                  child: Card1(
                    judul: "Bagaimana Saya Mengganti Password Akun",
                    isi:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue finibus tellus eget tempus. Ut orci nunc, fringilla eget fringilla semper, consequat non felis. Donec suscipit orci at dolor porttitor.u",
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class dummy {
  String test;

  dummy({required this.test});
}

class Card1 extends StatelessWidget {
  String isi;
  String judul;
  Card1({required this.judul, required this.isi});
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        child: Card(
          child: Column(
            children: [
              ScrollOnExpand(
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      tapBodyToCollapse: true, tapBodyToExpand: true),
                  header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      judul,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  expanded: Text(
                    isi,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  collapsed: Text(" "),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
