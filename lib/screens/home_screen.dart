import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/app_bar.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';
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
    //33.13 mnt
    userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.user.name!;

    return Scaffold(
      appBar: getAppBar(context,'App bar home',userProvider.user),
      drawer: AppDrawer(),
      body: Center(
        child: Text("BIENVENIDO " + name),
      ),
    );
  }
}
