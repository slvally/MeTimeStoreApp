import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: const EdgeInsets.all(21.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                'MeTime Store',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Text(
                'we are selling high quality product with amazing design',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF545454), fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              // margin: const EdgeInsets.only(bottom: 16, top: 32),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Intro2state()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0.0,
                  primary: const Color(0xFF1D1D1B),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black45)),
                ),
                child: const Text(
                  "Start The Journey",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Skip All',
                  style: TextStyle(color: Color(0xFF545454)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Intro2state extends StatelessWidget {
  const Intro2state({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 48),
              child: Text(
                'Feature',
                style: TextStyle(fontSize: 28),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.star,
                  size: 45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Amazing Design',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.discount,
                  size: 45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Affordable Price',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.local_shipping,
                  size: 45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Free Shipping',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.security,
                  size: 45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Safe Transaction',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Intro3state()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0.0,
                  primary: const Color(0xFF1D1D1B),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black45)),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Intro3state extends StatelessWidget {
  const Intro3state({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Image.asset("assets/intro3illust.png")),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Enjoy Your Shopping Time!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                elevation: 0.0,
                primary: const Color(0xFF1D1D1B),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black45)),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
