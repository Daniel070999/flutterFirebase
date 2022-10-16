import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/app_bar.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: getAppBar(context, 'mapa', userProvider.user),
      drawer: AppDrawer(),
      body: Container(),
    );
  }
}
