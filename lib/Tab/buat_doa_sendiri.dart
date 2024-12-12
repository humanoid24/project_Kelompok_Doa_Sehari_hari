import 'package:flutter/material.dart';
import 'package:project_app/buat_doa/doa_malam.dart';
import 'package:project_app/buat_doa/doa_pagi.dart';
import 'package:project_app/buat_doa/doa_siang.dart';
import 'package:project_app/widget/sidebar.dart';

class BuatDoaSendiri extends StatefulWidget {
  const BuatDoaSendiri({super.key});

  State<BuatDoaSendiri> createState() => _BuatDoaSendiriState();
}

class _BuatDoaSendiriState extends State<BuatDoaSendiri> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: Text("Doa eksternal", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          bottom: TabBar(tabs: [
            Tab(child: Text("Doa Pagi",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
            Tab(child: Text("Doa Siang",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
            Tab(child: Text("Doa Malam",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)))
          ]),
        ),
        body: TabBarView(children: [
          DoaPagi(),
          DoaSiang(),
          DoaMalam()
        ]),
      ),
    );
  }
}

