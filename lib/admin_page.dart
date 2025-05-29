import 'package:flutter/material.dart';
import 'laporan_page.dart'; // Sesuaikan path importnya

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selectedIndex = 0; // 0=Dashboard, 1=Laporan, 2=Pengaturan

  // Data Jasa (Dummy)
  List<Map<String, dynamic>> jasaList = [
    {'nama': 'Konsultasi Umum', 'harga': 50000},
  ];

  // Tambah/Edit Modal Controllers
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  bool isEditing = false;
  int? editingIndex;

  void openTambahModal() {
    _namaController.clear();
    _hargaController.clear();
    setState(() {
      isEditing = false;
    });
    showDialog(
      context: context,
      builder: (_) => jasaDialog(),
    );
  }

  void openEditModal(int index) {
    _namaController.text = jasaList[index]['nama'];
    _hargaController.text = jasaList[index]['harga'].toString();
    setState(() {
      isEditing = true;
      editingIndex = index;
    });
    showDialog(
      context: context,
      builder: (_) => jasaDialog(),
    );
  }

  void simpanJasa() {
    final nama = _namaController.text.trim();
    final harga = int.tryParse(_hargaController.text.trim()) ?? 0;
    if (nama.isEmpty || harga <= 0) return;

    setState(() {
      if (isEditing && editingIndex != null) {
        jasaList[editingIndex!] = {'nama': nama, 'harga': harga};
      } else {
        jasaList.add({'nama': nama, 'harga': harga});
      }
    });
    Navigator.of(context).pop();
  }

  void hapusJasa(int index) {
    setState(() {
      jasaList.removeAt(index);
    });
  }

  AlertDialog jasaDialog() {
    return AlertDialog(
      title: Text(isEditing ? 'Edit Jasa' : 'Tambah Jasa Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(labelText: 'Nama Jasa'),
          ),
          TextField(
            controller: _hargaController,
            decoration: const InputDecoration(labelText: 'Harga'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ElevatedButton(onPressed: simpanJasa, child: const Text('Simpan')),
      ],
    );
  }

  Widget buildDashboardPage() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Tambah Jasa'),
            onPressed: openTambahModal,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: jasaList.length,
            itemBuilder: (context, index) {
              final jasa = jasaList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(jasa['nama']),
                  subtitle: Text('Rp ${jasa['harga']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => openEditModal(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => hapusJasa(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSettingsPage() {
    return const Center(
      child: Text('Halaman Pengaturan (belum dibuat)'),
    );
  }

  Widget buildPageContent() {
    switch (selectedIndex) {
      case 1:
        return const LaporanPage();
      case 2:
        return buildSettingsPage();
      case 0:
      default:
        return buildDashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Jasa Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildPageContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
