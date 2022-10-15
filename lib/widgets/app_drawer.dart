import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Column(
            children: [
              Icon(Icons.person, size: 100)
            ],
          )),
          ListTile(
            title: Text('Home'),
            onTap: () {},
            selected: true,
          ),
          ListTile(
            title: Text('Mapa'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Temp 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Temp 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}