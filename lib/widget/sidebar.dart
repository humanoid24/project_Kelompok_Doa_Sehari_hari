import 'package:flutter/material.dart';
import 'package:project_app/Tab/buat_doa_sendiri.dart';
import 'package:project_app/Tab/doa_setelah_solatFarduSunnah.dart';
import 'package:project_app/Tab/doa_tab.dart';
import 'package:project_app/UI/doa_solat.dart';
import 'package:project_app/main.dart';
import 'package:project_app/opening.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatelessWidget {
  final SidebarXController controller = SidebarXController(selectedIndex: 0, extended: true);

  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: const SidebarXTheme(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        textStyle: TextStyle(color: Colors.white),
        selectedTextStyle: TextStyle(color: Colors.yellow),
        itemDecoration: BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(color: Colors.white24)),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.yellow,
          size: 28,
        ),
      ),
      extendedTheme: const SidebarXTheme(width: 200),
      headerBuilder: (context, extended) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Kumpulan Doa Doa',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DoaTab()));
          },
        ),
        SidebarXItem(
          icon: Icons.star,
          label: 'Buat Doa sendiri',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BuatDoaSendiri(
              ),
            ));
          },
        ),
        SidebarXItem(
          icon: Icons.book,
          label: 'Doa Setalah Solat fardu dan sunnah',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DoaSetelahSolatfardusunnah()));
          },
        ),
        SidebarXItem(
          icon: Icons.menu_book_rounded,
          label: 'Doa Solat',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoaSolat(),
            ));
          },
        ),
        SidebarXItem(
          icon: Icons.logout,
          label: 'Keluar',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Opening()));
          },
        ),
      ],
    );
  }
}
