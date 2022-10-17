import 'package:flutter/material.dart';
import 'package:practiacflutter/app_config.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(child: MyApp(), providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider())
      ]);
  }
  
    
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'minimizado',
      initialRoute: AppConfig.initialRoute,
      routes: AppConfig.routes(),
    );
  }
}
