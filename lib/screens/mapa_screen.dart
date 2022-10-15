import 'package:flutter/material.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maoa"),
      ),
      drawer: AppDrawer(),
      body: Container(),
    );
  }
}
