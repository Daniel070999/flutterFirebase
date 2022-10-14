import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.user.name!;

    return Scaffold(
      appBar: AppBar(
        title:  Text("practica flutter"),
      ),
      body: Center(
        child: Text("BIENVENIDO "+name),
      ),
    );
  }
}
