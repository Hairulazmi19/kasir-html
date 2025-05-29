import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  bool sidebarOpen = true;

  void toggleSidebar() {
    setState(() {
      sidebarOpen = !sidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final totalPendapatan = 300000;
    final totalTransaksi = 2;
    final rataRata = 150000;
    final transaksiDetail = [
      {
        "tanggal": "2025-05-01",
        "id": "ARX-001",
        "jasa": 50000,
        "obat": 100000,
        "total": 150000,
      },
      {
        "tanggal": "2025-05-02",
        "id": "ARX-002",
        "jasa": 50000,
        "obat": 100000,
        "total": 150000,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Transaksi'),
        leading: IconButton(
          icon: Icon(sidebarOpen ? Icons.menu_open : Icons.menu),
          onPressed: toggleSidebar,
        ),
      ),
      drawer: Drawer(
        // Kamu bisa isi dengan widget Sidebar-mu kalau sudah dibuat
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Admin Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Laporan'),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xfff1f3f6),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Summary cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SummaryCard(
                    title: 'Total Pendapatan',
                    value: 'Rp${totalPendapatan.toString()}',
                    icon: FontAwesomeIcons.moneyBillWave,
                    iconColor: Colors.green,
                    subtitle: 'Bulan Ini',
                  ),
                  _SummaryCard(
                    title: 'Total Transaksi',
                    value: totalTransaksi.toString(),
                    icon: FontAwesomeIcons.handHoldingUsd,
                    iconColor: Colors.blue,
                    subtitle: 'Bulan Ini',
                  ),
                  _SummaryCard(
                    title: 'Rata-rata',
                    value: 'Rp${rataRata.toString()}',
                    icon: FontAwesomeIcons.chartLine,
                    iconColor: Colors.lightBlue,
                    subtitle: 'Bulan Ini',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Detail Transaksi Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header with buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Detail Transaksi',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size(130, 36),
                                ),
                                onPressed: () {
                                  // TODO: Export Excel logic
                                },
                                icon: const FaIcon(FontAwesomeIcons.fileExport, size: 16),
                                label: const Text('Export Excel'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: const Size(120, 36),
                                ),
                                onPressed: () {
                                  // TODO: Export PDF logic
                                },
                                icon: const FaIcon(FontAwesomeIcons.filePdf, size: 16),
                                label: const Text('Export PDF'),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Table header
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(color: Color(0xfff8f9fa)),
                            children: [
                              _TableCellHeader(text: 'Tanggal'),
                              _TableCellHeader(text: 'ID Transaksi'),
                              _TableCellHeader(text: 'Jasa'),
                              _TableCellHeader(text: 'Obat'),
                              _TableCellHeader(text: 'Total'),
                            ],
                          ),
                          // Data rows
                          ...transaksiDetail.map(
                            (tr) => TableRow(
                              children: [
                                _TableCell(text: tr['tanggal'].toString()),
                                _TableCell(text: tr['id'].toString()),
                                _TableCell(text: 'Rp ${tr['jasa'].toString()}'),
                                _TableCell(text: 'Rp ${tr['obat'].toString()}'),
                                _TableCell(text: 'Rp ${tr['total'].toString()}'),
                              ],
                            ),
                          ),
                          // Total row
                          TableRow(
                            decoration: BoxDecoration(color: Colors.blue[100]),
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(), // empty cells
                              const SizedBox(),
                              const SizedBox(),
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rp${totalPendapatan.toString()}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Grafik placeholder
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Total Transaksi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      // Ganti dengan chart library (misal fl_chart) jika ingin dinamis
                      Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Grafik Total Transaksi Placeholder'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final String subtitle;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(icon, size: 28, color: iconColor),
                  const SizedBox(width: 8),
                  Text(subtitle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableCellHeader extends StatelessWidget {
  final String text;

  const _TableCellHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;

  const _TableCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
