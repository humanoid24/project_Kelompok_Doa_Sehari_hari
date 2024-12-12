import 'package:flutter/material.dart';
import 'package:project_app/UI/doa.dart';
import 'package:project_app/UI/favorite.dart';
import 'package:project_app/UI/tahlil.dart';
import 'package:project_app/widget/sidebar.dart';

class DoaTab extends StatefulWidget {
  const DoaTab({super.key});

  @override
  State<DoaTab> createState() => _DoaTabState();
}

class _DoaTabState extends State<DoaTab> {
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
              Tab(child: Text("Doa", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text("Doa Tahlil", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text("Favorite", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Doa(),
            Tahlil(),
            FavoritePage(),
          ],
        ),
      ),
    );
  }
}
