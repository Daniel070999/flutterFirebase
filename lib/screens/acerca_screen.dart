import 'package:flutter/material.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({super.key});

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acerca"),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text("App v 1.0 "),
      ),
    );
  }
}
