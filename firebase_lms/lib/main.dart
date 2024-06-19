import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_lms/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../custom_text_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EmergencyContactPage(),
    );
  }
}

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Kontak Baru'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  labelText: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon',
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    } else if (value.length < 8 || value.length > 15) {
                      return 'Nomor telepon harus antara 8-15 karakter';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addEmergencyContact(_nameController.text, _phoneNumberController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateContactDialog(DocumentSnapshot document) {
    _nameController.text = document['name'];
    _phoneNumberController.text = document['phoneNumber'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Kontak'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  labelText: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon',
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    } else if (value.length < 8 || value.length > 15) {
                      return 'Nomor telepon harus antara 8-15 karakter';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateEmergencyContact(document.id, _nameController.text, _phoneNumberController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(String id) {
    deleteEmergencyContact(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 192, 65, 1),
        title: Text(
          'Emergency Contact',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aparatur Negara',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('PL'),
                    ),
                    title: Text('Polisi'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('PK'),
                    ),
                    title: Text('Pemadam Kebakaran'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keluarga',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  MaterialButton(
                    onPressed: _showAddContactDialog,
                    child: Text("Tambah Kontak"),
                    color: Colors.lightBlueAccent,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('emergency contact')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No contacts available'));
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(data['name'][0].toUpperCase()),
                              ),
                              title: Text(data['name']),
                              subtitle: Text(data['phoneNumber']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => _showUpdateContactDialog(document),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteContact(document.id),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addEmergencyContact(String name, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('emergency contact').add({
      'name': name,
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> updateEmergencyContact(String id, String name, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('emergency contact').doc(id).update({
      'name': name,
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> deleteEmergencyContact(String id) async {
    await FirebaseFirestore.instance.collection('emergency contact').doc(id).delete();
  }
}
