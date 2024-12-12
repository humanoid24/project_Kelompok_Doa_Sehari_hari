import 'package:flutter/material.dart';
import 'package:project_app/database/doa_CRUD_malam_database.dart';

class DoaMalam extends StatefulWidget {
  const DoaMalam({super.key});

  @override
  State<DoaMalam> createState() => _DoaMalamState();
}

class _DoaMalamState extends State<DoaMalam> {
  List<Map<String, dynamic>> _doaList = [];

  @override
  void initState() {
    super.initState();
    _loadDoaList();
  }

  Future<void> _loadDoaList() async {
    final tambahDoa = await DoaCrudDatabaseMalam.getTambahDoaListMalam();
    setState(() {
      _doaList = tambahDoa;
    });
  }

  Future<void> _deleteDoa(int id) async {
    await DoaCrudDatabaseMalam.deleteDoaMalam(id);
    _loadDoaList();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Doa berhasil dihapus!')),
    );
  }

  Future<void> _showAddEditDialog({Map<String, dynamic>? doaData}) async {
    final _formKey = GlobalKey<FormState>();
    final _namaController = TextEditingController(text: doaData?['nama'] ?? '');
    final _arabController = TextEditingController(text: doaData?['arab'] ?? '');
    final _artiController = TextEditingController(text: doaData?['arti'] ?? '');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(doaData == null ? 'Tambah Doa' : 'Edit Doa'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama Doa'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama doa tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _arabController,
                    decoration: const InputDecoration(labelText: 'Teks Arab'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Teks Arab tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _artiController,
                    decoration: const InputDecoration(labelText: 'Arti Doa'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Arti doa tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final nama = _namaController.text.trim();
                final arab = _arabController.text.trim();
                final arti = _artiController.text.trim();

                if (doaData == null) {
                  // Tambah Doa
                  await DoaCrudDatabaseMalam.insertDoaMalam(nama, arab, arti);
                } else {
                  // Edit Doa
                  final id = doaData['id'];
                  await DoaCrudDatabaseMalam.updateDoaMalam(id, nama, arab, arti);
                }

                Navigator.pop(context);
                _loadDoaList(); // Refresh data
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(doaData == null
                        ? 'Doa berhasil ditambahkan!'
                        : 'Doa berhasil diperbarui!'),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _doaList.isEmpty
          ? const Center(
        child: Text("Doa Malam Belum di isi",style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)
        ),
      )
          : ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          ..._doaList.map((doa) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doa['nama'] ?? 'Tidak ada nama',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    doa['arab'] ?? 'Tidak ada teks arab',
                    style: const TextStyle(
                        fontSize: 25, fontStyle: FontStyle.italic),
                    textAlign:
                    TextAlign.right, // Teks Arab ditulis dari kanan
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Artinya: ${doa['arti'] ?? 'Tidak ada arti'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showAddEditDialog(doaData: doa); // Edit Doa
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteDoa(doa['id']),
                        ),
                      ]),
                ],
              ),
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddEditDialog(); // Menambah Doa baru
        },
      ),
    );
  }
}
