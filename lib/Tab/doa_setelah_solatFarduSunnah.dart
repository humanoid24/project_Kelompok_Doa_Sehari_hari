import 'package:flutter/material.dart';
import 'package:project_app/UI/doa_setelah_solatFardu.dart';
import 'package:project_app/UI/doa_setelah_solatSunnah.dart';
import 'package:project_app/widget/sidebar.dart';

class DoaSetelahSolatfardusunnah extends StatefulWidget {
  const DoaSetelahSolatfardusunnah({super.key});

  @override
  State<DoaSetelahSolatfardusunnah> createState() => _DoaSetelahSolatfardusunnahState();
}

class _DoaSetelahSolatfardusunnahState extends State<DoaSetelahSolatfardusunnah> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: const Text('Kumpulan Doa dan Doa tahlil',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("Doa Setelah Solat Fardu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text("Doa Setelah Solat Sunah", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DoaSetelahSolatFardu(),
            DoaSetelahSolatSunnah()
          ],
        ),
      ),
    );
  }
}
