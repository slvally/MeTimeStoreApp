import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubes_provis/controllers/cartController.dart';
import 'profile.dart';
import 'faq.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// import state
import 'home.dart';
import 'cart.dart';
import 'about.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  final cartTest = Get.put(CartController());
  int idx = 0;
  static List<Widget> halaman = [
    HomePage(),
    ProfilePage(),
    CartPage(),
    FaqPage(),
    AboutPage()
  ];
  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: halaman[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onItemTap, //event saat button di tap
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIcons.house, // Pencil Icon
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIcons.userCircle, // Pencil Icon
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIcons.shoppingCartSimple, // Pencil Icon
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIcons.question, // Pencil Icon
              ),
              label: "FAQ"),
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIcons.info, // Pencil Icon
              ),
              label: "About")
        ],
      ),
    );
  }
}
