import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/app_bar.dart';
import 'package:practiacflutter/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late UserProvider userProvider = UserProvider();
  Location location = Location();
  late StreamSubscription<LocationData> listen;
  double? latitud;
  double? longitud;

  @override
  void initState() {
    configLocation();
    super.initState();
  }

  configLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.enableBackgroundMode(enable: true);
    _locationData = await location.getLocation();
    longitud = _locationData.longitude;
    latitud = _locationData.latitude;

    listen = location.onLocationChanged.listen((LocationData currentLocation) {
      longitud = currentLocation.longitude;
      latitud = currentLocation.latitude;
      if (userProvider != null) {
        userProvider.setUserLocation(latitud!, longitud!);
      }
      setState(() {});
    });
    listen.resume();
  }

  @override
  void dispose() {
    listen.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: getAppBar(context, 'mapa', userProvider.user),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Center(child: Text(longitud.toString()+" / "+latitud.toString()))
        ],
      ),
    );
  }
}
