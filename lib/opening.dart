import 'dart:io'; // Tambahkan ini untuk menggunakan exit(0)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahkan untuk SystemNavigator.pop
import 'package:project_app/Tab/buat_doa_sendiri.dart';
import 'package:project_app/Tab/doa_setelah_solatFarduSunnah.dart';
import 'package:project_app/Tab/doa_tab.dart';
import 'package:project_app/UI/doa_solat.dart';

class Opening extends StatefulWidget {
  const Opening({super.key});

  @override
  State<Opening> createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  Future<void> _showExitConfirmationDialog() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Keluar"),
          content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Batalkan
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true); // Konfirmasi keluar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Keluar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (shouldExit == true) {
      if (Platform.isAndroid || Platform.isIOS) {
        SystemNavigator.pop(); // Keluar untuk aplikasi mobile
      } else {
        exit(0); // Keluar untuk platform lainnya
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selamat Datang"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoaTab()),
                  );
                },
                child: const Text("Doa Sehari-hari dan tahlil"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuatDoaSendiri()),
                  );
                },
                child: const Text("Tambahkan Doa"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoaSetelahSolatfardusunnah()),
                  );
                },
                child: const Text("Doa Setelah Solat"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoaSolat()),
                  );
                },
                child: const Text("Doa Solat"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _showExitConfirmationDialog, // Tambahkan fungsi ini
                child: const Text("Keluar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
