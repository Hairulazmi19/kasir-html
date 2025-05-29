import 'package:flutter/material.dart';

class KasirPage extends StatefulWidget {
  const KasirPage({super.key});

  @override
  _KasirPageState createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> antrian = [
    {'noAntrian': 'TRX-001', 'namaPasien': 'Budi Santoso', 'poli': 'Umum'},
    {'noAntrian': 'TRX-002', 'namaPasien': 'Siti Aminah', 'poli': 'Anak'},
  ];

  final List<Map<String, String>> riwayatTransaksi = [
    {'noTransaksi': 'TRX-0001', 'namaPasien': 'Andi', 'totalBiaya': 'Rp150.000', 'tanggal': '2024-03-01', 'status': 'Sudah Bayar'},
    {'noTransaksi': 'TRX-0002', 'namaPasien': 'Rina', 'totalBiaya': 'Rp200.000', 'tanggal': '2024-03-02', 'status': 'Sudah Bayar'},
  ];

  Map<String, String> selectedTransaction = {};
  bool isModalOpen = false;

  void openModal(Map<String, String> transaction) {
    setState(() {
      selectedTransaction = transaction;
      isModalOpen = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DetailTransaksiDialog(
        transaction: transaction,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPembayaran() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12,
          columns: const [
            DataColumn(label: Text('No Antrian')),
            DataColumn(label: Text('Pasien')),
            DataColumn(label: Text('Poli')),
            DataColumn(label: Text('Aksi')),
          ],
          rows: antrian.map((trx) {
            return DataRow(cells: [
              DataCell(Text(trx['noAntrian']!)),
              DataCell(Text(trx['namaPasien']!)),
              DataCell(Text(trx['poli']!)),
              DataCell(ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: const Text('Proses', style: TextStyle(fontSize: 12)),
                onPressed: () => openModal(trx),
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRiwayat() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12,
          columns: const [
            DataColumn(label: Text('No Transaksi')),
            DataColumn(label: Text('Pasien')),
            DataColumn(label: Text('Biaya')),
            DataColumn(label: Text('Tanggal')),
            DataColumn(label: Text('Status')),
          ],
          rows: riwayatTransaksi.map((trx) {
            return DataRow(cells: [
              DataCell(Text(trx['noTransaksi']!)),
              DataCell(Text(trx['namaPasien']!)),
              DataCell(Text(trx['totalBiaya']!)),
              DataCell(Text(trx['tanggal']!)),
              DataCell(Text(trx['status']!)),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_selectedIndex == 0 ? 'Pembayaran' : 'Riwayat Transaksi'),
          centerTitle: true,
        ),
        body: _selectedIndex == 0 ? _buildPembayaran() : _buildRiwayat(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Pembayaran'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class DetailTransaksiDialog extends StatelessWidget {
  final Map<String, String> transaction;
  final VoidCallback onClose;

  const DetailTransaksiDialog({
    super.key,
    required this.transaction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Detail Transaksi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _readonlyField('No. Antrian', transaction['noAntrian']),
              _readonlyField('Nama Pasien', transaction['namaPasien']),
              _readonlyField('Poli', transaction['poli']),
              const SizedBox(height: 16),
              const Text('Rincian Biaya (simulasi)'),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Metode Pembayaran'),
                items: const [
                  DropdownMenuItem(value: 'tunai', child: Text('Tunai')),
                  DropdownMenuItem(value: 'debit', child: Text('Debit')),
                  DropdownMenuItem(value: 'transfer', child: Text('Transfer')),
                  DropdownMenuItem(value: 'ewallet', child: Text('E-Wallet')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.print, size: 16),
                      label: const Text('Bayar & Cetak'),
                      onPressed: onClose,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onClose,
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                      child: const Text('Batal'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _readonlyField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: value ?? '',
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}
