import 'package:flutter/material.dart';
import 'package:profil/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormData extends StatefulWidget {
  const FormData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _nohpController = TextEditingController();
  final _emailController = TextEditingController();
  final _fakultasController = TextEditingController();
  final _alamatController = TextEditingController();
  final _jurusanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? profil = prefs.getStringList('mhs');
    if (profil != null) {
      setState(() {
        _nimController.text = profil[0];
        _namaController.text = profil[1];
        _nohpController.text = profil[2];
        _emailController.text = profil[3];
        _fakultasController.text = profil[4];
         _fakultasController.text = profil[5];
        _jurusanController.text = profil[6];
      });
    }
  }

  TextFormField _textbox(String label, controller,
      {bool isEmail = false, bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (isNumeric ? TextInputType.phone : TextInputType.text),
      // Validasi input email jika isEmail adalah true
      validator: (value) {
        if (isEmail && !isValidEmail(value)) {
          return 'Masukkan alamat email yang valid';
        }
        if (isNumeric && !isNumericString(value)) {
          return 'Masukkan nomor HP yang valid';
        }
        return null;
      },
    );
  }

// Fungsi untuk memeriksa apakah email valid menggunakan ekspresi reguler
  bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false; // If email is null or empty, consider it invalid
    }

    // Memeriksa apakah email mengandung karakter "@"
    if (!value.contains('@')) {
      return false;
    }

    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegExp.hasMatch(value);
  }

// Fungsi untuk memeriksa apakah string hanya berisi angka
  bool isNumericString(String? value) {
    if (value == null || value.isEmpty) {
      return false; // If no is null or empty, consider it invalid
    }
    final numericRegExp = RegExp(r'^[0-9]+$');
    return numericRegExp.hasMatch(value);
  }

  _savedata(key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Profil'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          _textbox('NIM', _nimController),
          _textbox('Nama', _namaController),
          _textbox('No HP', _nohpController, isNumeric: true),
          _textbox('E-mail', _emailController, isEmail: true),
          _textbox('Fakultas', _fakultasController),
           _textbox('Alamat', _alamatController),
          _textbox('Jurusan', _jurusanController),
          ElevatedButton(
            onPressed: () {
              if (_nimController.text.isEmpty || _namaController.text.isEmpty) {
                // Menampilkan pesan jika NIM atau nama kosong
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('NIM dan Nama harus diisi.'),
                  ),
                );
              } else if (_emailController.text.isNotEmpty &&
                  !isValidEmail(_emailController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Masukkan alamat email yang valid.'),
                  ),
                );
              } else if (_nohpController.text.isNotEmpty &&
                  !isNumericString(_nohpController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Masukkan nomor HP yang valid.'),
                  ),
                );
              } else {
                List<String> profil = [
                  _nimController.text,
                  _namaController.text,
                  _nohpController.text,
                  _emailController.text,
                  _fakultasController.text,
                 _alamatController.text,
                  _jurusanController.text,
                ];
                _savedata('mhs', profil);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Profil(),
                ));
              }
            },
            child: const Text("Simpan"),
          )
        ]),
      ),
    );
  }
}
//ini tugas 3 bagian form_data.dart