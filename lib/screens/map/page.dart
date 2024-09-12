import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator
import 'package:url_launcher/url_launcher.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late MapController _mapController;
  LatLng _currentLocation =
  LatLng(28.6139, 77.2090); // Default location: New Delhi
  LatLng? _selectedLocation;
  List<LatLng> _routePoints = [];
  Timer? _travelTimer;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _checkPermissions();
  }

  @override
  void dispose() {
    _travelTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.location.status;

    if (status.isDenied) {
      final result = await Permission.location.request();
      if (result.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location permission is required for this feature.'),
        ));
      } else {
        // Permission granted, get the current location
        _getCurrentLocation();
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      // Permission already granted, get the current location
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentLocation, 15.0);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred while getting location: $e'),
      ));
    }
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newLocation = LatLng(location.latitude, location.longitude);

        setState(() {
          _selectedLocation = newLocation;
          _routePoints.clear();
        });

        _mapController.move(newLocation, 12.0);

        // Show confirmation dialog to start navigation
        _showNavigationDialog(newLocation);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location not found.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred while searching: $e'),
      ));
    }
  }

  void _showNavigationDialog(LatLng newLocation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Navigation'),
          content: Text('Do you want to start navigation to this location?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Start'),
              onPressed: () {
                Navigator.of(context).pop();
                _calculateRoute(_currentLocation, newLocation);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _calculateRoute(LatLng start, LatLng end) async {
    final url =
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<LatLng> points = [];
        final List<dynamic> coordinates =
        data['routes'][0]['geometry']['coordinates'];

        for (var coord in coordinates) {
          points.add(LatLng(coord[1], coord[0]));
        }

        setState(() {
          _routePoints = points;
        });

        _startTravel();
      } else {
        throw Exception('Failed to load route');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to calculate route: $e'),
      ));
    }
  }

  void _startTravel() {
    _currentStep = 0;
    _travelTimer?.cancel();
    if (_routePoints.isNotEmpty) {
      _travelTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        if (_currentStep < _routePoints.length) {
          setState(() {
            _currentLocation = _routePoints[_currentStep];
          });
          _mapController.move(_currentLocation, 15.0);
          _currentStep++;
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Search and Travel Mechanism'),
        backgroundColor: const Color(0xFF614a38),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchLocation(value);
                }
              },
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 15.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                    _routePoints.clear();
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  maxNativeZoom: 19,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                        point: _currentLocation,
                        width: 150,
                        height: 150,
                        child: Icon(Icons.place, color: Colors.red)),
                    if (_selectedLocation != null)
                      Marker(
                        point: _selectedLocation!,
                        width: 80,
                        height: 80,
                        child: Icon(Icons.place, color: Colors.blue),
                      ),
                  ],
                ),
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        strokeWidth: 6.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
