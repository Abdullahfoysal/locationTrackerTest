import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationTracker(),
    );
  }
}

class LocationTracker extends StatefulWidget {
  @override
  _LocationTrackerState createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    //var geolocator = Geolocator();
    LocationPermission permission;

    // Check if location permissions are granted
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
      return;
    }

    // Get the current position
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracker'),
      ),
      body: Center(
        child: _currentPosition != null
            ? Text(
            'LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}')
            : CircularProgressIndicator(),
      ),
    );
  }
}