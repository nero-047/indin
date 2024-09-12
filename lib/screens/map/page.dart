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

  // Heritage sites coordinates
  final List<Map<String, dynamic>> _heritageSites = [
    {
      'name': 'Capitol Complex, Chandigarh',
      'location': LatLng(30.7580, 76.7684)
    },
    {'name': 'Rock Garden, Chandigarh', 'location': LatLng(30.7525, 76.8101)},
    {'name': 'Sukhna Lake, Chandigarh', 'location': LatLng(30.7421, 76.8188)},
    {'name': 'Fateh Burj, Mohali', 'location': LatLng(30.6445, 76.7176)},
    {
      'name': 'Gurdwara Amb Sahib, Mohali',
      'location': LatLng(30.7070, 76.7079)
    },
    {'name': 'Chappar Chiri, Mohali', 'location': LatLng(30.6205, 76.6921)},
    {
      'name': 'Open Hand Monument, Chandigarh',
      'location': LatLng(30.7526, 76.7684)
    },
    {
      'name': 'Punjab University, Chandigarh',
      'location': LatLng(30.7612, 76.7681)
    },
    {
      'name': 'Le Corbusier Centre, Chandigarh',
      'location': LatLng(30.7352, 76.7910)
    },
    {
      'name': 'Government Museum and Art Gallery, Chandigarh',
      'location': LatLng(30.7421, 76.7852)
    },
    {
      'name': 'Mata Mansa Devi Temple, Panchkula',
      'location': LatLng(30.7026, 76.8530)
    },
    {
      'name': 'Pinjore Gardens, Panchkula',
      'location': LatLng(30.7980, 76.9140)
    },
    {
      'name': 'Bhima Devi Temple, Pinjore',
      'location': LatLng(30.7923, 76.9146)
    },
    {
      'name': 'Nek Chand’s Rock Garden, Chandigarh',
      'location': LatLng(30.7525, 76.8120)
    },
    {'name': 'Rose Garden, Chandigarh', 'location': LatLng(30.7410, 76.7825)},
    {
      'name': 'Yadvindra Gardens, Pinjore',
      'location': LatLng(30.7932, 76.9143)
    },
    {
      'name': 'Gurudwara Nada Sahib, Panchkula',
      'location': LatLng(30.6939, 76.8867)
    },
    {'name': 'Cactus Garden, Panchkula', 'location': LatLng(30.6920, 76.8534)},
    {
      'name': 'Haryana Raj Bhawan, Chandigarh',
      'location': LatLng(30.7587, 76.7739)
    },
    {'name': 'ISKCON Temple, Chandigarh', 'location': LatLng(30.7359, 76.7982)},
    {
      'name': 'Mahendra Chaudhary Zoological Park, Chhatbir',
      'location': LatLng(30.5881, 76.7942)
    },
    {'name': 'Baoli Sahib, Mohali', 'location': LatLng(30.7245, 76.7075)},
    {
      'name': 'Elante Mall, Chandigarh',
      'location': LatLng(30.7057, 76.8014)
    }, // Popular landmark
    {
      'name': 'Zakir Hussain Rose Garden, Chandigarh',
      'location': LatLng(30.7442, 76.7871)
    },
    {
      'name': 'Garden of Silence, Chandigarh',
      'location': LatLng(30.7417, 76.8153)
    },
    {
      'name': 'Tower of Shadows, Chandigarh',
      'location': LatLng(30.7585, 76.7680)
    },
    {
      'name': 'Gurudwara Singh Shaheedan, Mohali',
      'location': LatLng(30.6627, 76.7237)
    },
    {
      'name': 'Mansa Devi Temple, Chandigarh',
      'location': LatLng(30.7010, 76.8525)
    },
    {
      'name': 'Shanti Kunj Park, Chandigarh',
      'location': LatLng(30.7427, 76.7894)
    },
    {'name': 'War Memorial, Chandigarh', 'location': LatLng(30.7581, 76.7666)},
    {
      'name': 'Hibiscus Garden, Chandigarh',
      'location': LatLng(30.7348, 76.7899)
    },
    {
      'name': 'Gurudwara Sri Katalgarh Sahib, Kharar',
      'location': LatLng(30.7428, 76.6472)
    },
    {'name': 'Shaheed Smarak, Mohali', 'location': LatLng(30.6403, 76.6738)},
    {
      'name': 'Nada Sahib Gurudwara, Panchkula',
      'location': LatLng(30.6951, 76.8867)
    },
    {
      'name': 'Lakhnaur Sahib Gurudwara, Mohali',
      'location': LatLng(30.6477, 76.7356)
    },
    {
      'name': 'Garden of Fragrance, Chandigarh',
      'location': LatLng(30.7328, 76.7922)
    },
    {
      'name': 'Japanese Garden, Chandigarh',
      'location': LatLng(30.7211, 76.8027)
    },
    {
      'name': 'Botanical Garden, Chandigarh',
      'location': LatLng(30.7324, 76.7712)
    },
    {
      'name': 'Terraced Garden, Chandigarh',
      'location': LatLng(30.7312, 76.7759)
    },
    {
      'name': 'Sector 17 Plaza, Chandigarh',
      'location': LatLng(30.7375, 76.7819)
    },
  ];

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
        _getCurrentLocation();
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
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
        title: Text('Map with Heritage Sites'),
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
                    // Marker for current location
                    Marker(
                      point: _currentLocation,
                      width: 300,
                      height: 300,
                      child: Icon(Icons.place, color: Colors.red),
                      rotate: true,
                    ),
                    // Markers for heritage sites
                    ..._heritageSites.map((site) => Marker(
                          rotate: true,
                          point: site['location'],
                          width: 400,
                          height: 300,
                          child: Column(
                            children: [
                              // Icon(Icons.place, color: Colors.blue),
                              IconButton(onPressed: (){}, icon: Icon(Icons.place),color: Colors.blue,),
                              Text(
                                site['name'],
                                style:
                                    TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                    if (_selectedLocation != null)
                      Marker(
                        point: _selectedLocation!,
                        width: 80,
                        height: 80,
                        child: Icon(Icons.place, color: Colors.transparent),
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
