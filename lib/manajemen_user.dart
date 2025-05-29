import 'package:flutter/material.dart';

class ManajemenUser extends StatefulWidget {
  const ManajemenUser({super.key});

  @override
  _ManajemenUserState createState() => _ManajemenUserState();
}

class _ManajemenUserState extends State<ManajemenUser> {
  List<Map<String, String>> users = [
    {'id': 'USR-001', 'nama': 'Irfan Sigma', 'role': 'Admin', 'username': 'irfan'},
    {'id': 'USR-002', 'nama': 'Azriel Crocodili', 'role': 'Kasir', 'username': 'azriel'},
  ];

  // Untuk form tambah/edit
  final _formKey = GlobalKey<FormState>();
  String? _id, _nama, _username, _password;
  bool isEdit = false;

  void _showUserDialog({Map<String, String>? user}) {
    if (user != null) {
      // Mode edit
      isEdit = true;
      _id = user['id'];
      _nama = user['nama'];
      _username = user['username'];
    } else {
      // Mode tambah
      isEdit = false;
      _id = null;
      _nama = null;
      _username = null;
    }
    _password = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEdit ? 'Edit User' : 'Tambah User'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isEdit)
                  TextFormField(
                    initialValue: _id,
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'ID User'),
                  ),
                TextFormField(
                  initialValue: _nama,
                  decoration: InputDecoration(labelText: 'Nama'),
                  onChanged: (val) => _nama = val,
                  validator: (val) => val!.isEmpty ? 'Nama wajib diisi' : null,
                ),
                TextFormField(
                  initialValue: _username,
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (val) => _username = val,
                  validator: (val) => val!.isEmpty ? 'Username wajib diisi' : null,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (val) => _password = val,
                  validator: (val) => val!.isEmpty ? 'Password wajib diisi' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton(
            child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  if (isEdit) {
                    // Update user
                    final index = users.indexWhere((u) => u['id'] == _id);
                    if (index != -1) {
                      users[index] = {
                        'id': _id!,
                        'nama': _nama!,
                        'username': _username!,
                        'role': users[index]['role']!,
                      };
                    }
                  } else {
                    // Tambah user baru
                    final newId = 'USR-${(users.length + 1).toString().padLeft(3, '0')}';
                    users.add({
                      'id': newId,
                      'nama': _nama!,
                      'username': _username!,
                      'role': 'Kasir',
                    });
                  }
                });
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }

  void _deleteUser(String id) {
    setState(() {
      users.removeWhere((u) => u['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => _showUserDialog(),
              icon: Icon(Icons.add),
              label: Text('Tambah Kasir'),
            ),
            Expanded(
              child: ListView(
                children: users
                    .map(
                      (user) => Card(
                        child: ListTile(
                          title: Text('${user['nama']}'),
                          subtitle: Text('Role: ${user['role']} | ID: ${user['id']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _showUserDialog(user: user),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(user['id']!),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
