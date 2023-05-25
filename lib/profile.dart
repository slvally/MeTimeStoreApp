import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_provis/chart.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfileState();
}

var date = DateTime.now();
var rangeDate = DateTime(date.year, date.month - 5, date.day);
var month = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MEI",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DES"
];

class _ProfileState extends State<ProfilePage> {
  List<String> gambar = [];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage(
                  'https://res.cloudinary.com/dnjyydnmc/image/upload/v1672586458/WhatsApp_Image_2022-12-28_at_14.13.35_fd0kei.jpg'),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${user.email!}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            // Text('${user.displayName}', style: TextStyle(fontSize: 18.0)),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Sign Out"),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Pembelian 5 Bulan Terakhir',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("checkout")
                    .where("timestamp", isGreaterThan: rangeDate)
                    .where("uid", isEqualTo: user.uid.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var data = snapshot.data!.docs.map((e) {
                    Timestamp ts = e['timestamp'] as Timestamp;
                    DateTime date = ts.toDate();
                    int formatted = int.parse(DateFormat.M().format(date)) - 1;
                    return chartData(month[formatted], 1);
                  }).toList();
                  var newData = groupBy(data, (obj) => obj.month);
                  // print(newData);
                  int idx = DateTime.now().month - 5;
                  if (idx < 0) idx = 12 + idx;
                  List<chartDataDraw>? dataFix = [];
                  for (int i = 0; i < 5; i++) {
                    dataFix.add(chartDataDraw(0, month[idx]));
                    idx++;
                    if (idx > 11) idx = 0;
                  }
                  dataFix.forEach((e) {
                    if (newData.containsKey(e.time)) {
                      e.value = newData[e.time]!.length.toDouble();
                    }
                  });

                  return Container(
                      color: Colors.red,
                      child: SizedBox(
                        height: 300,
                        child: Chart(dataFix),
                      ));
                })
          ],
        ),
      ),
    );
  }
}

class chartData {
  String month;
  int total;
  chartData(this.month, this.total);
}
