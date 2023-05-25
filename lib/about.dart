import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'ABOUT',
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
        minimum: EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 32, top: 32),
                    // decoration:
                    // BoxDecoration(border: Border.all(color: Colors.black)),
                    // width: Get.width * 0.4,
                    // height: Get.height * 0.6,
                    child: Image.asset(
                      "assets/SplashLogo.png",
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  // decoration:
                  // BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Text(
                    "Deskripsi Aplikasi",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 800,
                  height: 150,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue finibus tellus eget tempus. Ut orci nunc, fringilla eget fringilla semper, consequat non felis. Donec suscipit orci at dolor porttitor.",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    "Pengembang",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(children: [
                    Text(
                        "Arik Rizki Akbar - Cahya Gumilang - Raden Fadhil A A - Muhammad Rafi Shidiq")
                  ]),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
