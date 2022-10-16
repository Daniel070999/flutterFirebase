import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/app_bar.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({super.key});

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: getAppBar(context,'App bar home',userProvider.user),
      drawer: const AppDrawer(),
      body: Center(
        child: Text("App v 1.0 "),
      ),
    );
  }
}
