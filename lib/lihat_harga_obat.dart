import 'package:flutter/material.dart';

class LihatHargaObatAdmin extends StatelessWidget {
  const LihatHargaObatAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lihat Harga Obat"),
        backgroundColor: Colors.blue[900],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu Admin",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text("Harga Obat"),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF1F3F6),
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daftar Harga Obat",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateColor.resolveWith(
                        (states) => Colors.blue.shade100),
                    columns: const [
                      DataColumn(label: Text("No")),
                      DataColumn(label: Text("Nama Obat")),
                      DataColumn(label: Text("Harga")),
                      DataColumn(label: Text("Stok")),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("Paracetamol")),
                        DataCell(Text("Rp 10.000")),
                        DataCell(Text("100")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("2")),
                        DataCell(Text("Ibuprofen")),
                        DataCell(Text("Rp 15.000")),
                        DataCell(Text("50")),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
