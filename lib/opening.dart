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
      body: Stack(
        children: [
          // Gambar background full cover
          Positioned.fill(
            child: Image.asset(
              'assets/body.png', // Lokasi gambar Anda
              fit: BoxFit.cover, // Gambar mengisi seluruh ruang
            ),
          ),
          // Konten di atas gambar
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol-tombol lainnya dengan border
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoaTab()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Transparan
                      elevation: 0, // Hapus bayangan
                      padding: EdgeInsets.symmetric(vertical: 16), // Padding tombol
                      side: BorderSide(color: Colors.white, width: 2), // Garis border
                    ),
                    child: const Text(
                      "Doa Sehari-hari dan tahlil",
                      style: TextStyle(color: Colors.white), // Warna teks tombol
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.white, width: 2), // Garis border
                    ),
                    child: const Text(
                      "Tambahkan Doa",
                      style: TextStyle(color: Colors.white),
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.white, width: 2), // Garis border
                    ),
                    child: const Text(
                      "Doa Setelah Solat",
                      style: TextStyle(color: Colors.white),
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.white, width: 2), // Garis border
                    ),
                    child: const Text(
                      "Doa Solat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _showExitConfirmationDialog, // Tambahkan fungsi ini
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.white, width: 2), // Garis border
                    ),
                    child: const Text(
                      "Keluar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
