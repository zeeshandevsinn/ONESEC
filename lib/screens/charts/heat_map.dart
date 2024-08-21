// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class HeatMapScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Geographic Heat Map',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: HeatMapWidget(
//                   countryNames: [
//                     'United States',
//                     'China',
//                     'India'
//                   ], // Example countries
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Legend: The colors represent the intensity of data for each region.',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HeatMapWidget extends StatelessWidget {
//   final List<String> countryNames;

//   HeatMapWidget({required this.countryNames});

//   @override
//   Widget build(BuildContext context) {
//     List<CountryData> countries = loadHeatMapData(countryNames);

//     return FlutterMap(
//       options: MapOptions(
//         center: LatLng(20.0, 0.0), // Center of the map
//         zoom: 2.0, // Initial zoom level
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'com.example.app',
//           retinaMode: RetinaMode.isHighDensity(context),
//         ),
//         MarkerLayer(
//           markers: countries.map((country) {
//             return Marker(
//               point: country.position,
//               width: country.intensity * 50, // Scale with intensity
//               height: country.intensity * 50,
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.red
//                       .withOpacity(country.intensity), // Heat intensity
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${country.value}',
//                     style: TextStyle(color: Colors.white, fontSize: 10),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

// List<CountryData> loadHeatMapData(List<String> countryNames) {
//   // Example coordinates for countries (this should be expanded)
//   Map<String, LatLng> countryCoordinates = {
//     'United States': LatLng(37.7749, -122.4194), // Example: San Francisco
//     'China': LatLng(39.9042, 116.4074), // Beijing
//     'India': LatLng(28.6139, 77.2090), // New Delhi
//     // Add more country mappings here...
//   };

//   List<CountryData> countryData = [];

//   for (String countryName in countryNames) {
//     if (countryCoordinates.containsKey(countryName)) {
//       countryData.add(
//         CountryData(
//           countryCode: countryName,
//           position: countryCoordinates[countryName]!,
//           intensity: 0.7, // Example intensity, adjust based on your data
//           value: 4900, // Example value, adjust based on your data
//         ),
//       );
//     }
//   }

//   return countryData;
// }

// class CountryData {
//   final String countryCode;
//   final LatLng position;
//   final double intensity;
//   final int value;

//   CountryData({
//     required this.countryCode,
//     required this.position,
//     required this.intensity,
//     required this.value,
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HeatMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Geographic Heat Map',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: HeatMapWidget(
                  countries: [
                    CountryData(
                      countryName: 'Pakistan',
                      coordinates: [
                        LatLng(30.0, 60.0),
                        LatLng(30.0, 70.0),
                        LatLng(25.0, 70.0),
                        LatLng(25.0, 60.0),
                      ],
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    CountryData(
                      countryName: 'China',
                      coordinates: [
                        LatLng(35.0, 105.0),
                        LatLng(35.0, 115.0),
                        LatLng(25.0, 115.0),
                        LatLng(25.0, 105.0),
                      ],
                      color: Colors.red.withOpacity(0.5),
                    ),
                    // Add more countries as needed
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Legend: The colors represent different countries.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeatMapWidget extends StatelessWidget {
  final List<CountryData> countries;

  HeatMapWidget({required this.countries});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(20.0, 0.0),
        zoom: 2.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        PolygonLayer(
          polygons: countries.map((country) {
            return Polygon(
              points: country.coordinates,
              color: country.color,
              borderColor: Colors.black,
              borderStrokeWidth: 2,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CountryData {
  final String countryName;
  final List<LatLng> coordinates;
  final Color color;

  CountryData({
    required this.countryName,
    required this.coordinates,
    required this.color,
  });
}
