import 'package:flutter/material.dart';
import 'package:profil/side_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  // ignore: prefer_typing_uninitialized_variables
  var profil;

  @override
  void initState() {
    super.initState();
    _loadProfil();
  }

  _loadProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profil = prefs.getStringList('mhs');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      body: Center(
        child: _buildProfilCard(),
      ),
      drawer: const SideMenu(),
    );
  }

  Widget _buildProfilCard() {
    // Check if profil is null or empty before displaying
    if (profil == null || profil.isEmpty) {
      return const CircularProgressIndicator(); // Display a loading indicator if data is not yet loaded
    }

    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('NIM'),
            subtitle: Text(profil[0]), // Replace with NIM from profil
          ),
          ListTile(
            title: const Text('Nama'),
            subtitle: Text(profil[1]), // Replace with Nama from profil
          ),
          ListTile(
            title: const Text('No HP'),
            subtitle: Text(profil[2]), // Replace with No HP from profil
          ),
          ListTile(
            title: const Text('E-mail'),
            subtitle: Text(profil[3]), // Replace with E-mail from profil
          ),
          ListTile(
            title: const Text('Fakultas'),
            subtitle: Text(profil[4]), // Replace with Fakultas from profil
            ),
          ListTile(
            title: const Text('Alamat'),
            subtitle: Text(profil[4]), // Replace with Alamat from profil
          ),
          ListTile(
            title: const Text('Jurusan'),
            subtitle: Text(profil[5]), // Replace with Jurusan from profil
          ),
        ],
      ),
    );
  }
}
//ini bagian profil.dart
