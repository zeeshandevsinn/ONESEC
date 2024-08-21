import 'package:latlong2/latlong.dart';

class CountryData {
  final String countryCode;
  final LatLng position; // Position on the map (latitude and longitude)
  final double intensity; // Value that determines heat map intensity
  final int value;

  CountryData({
    required this.countryCode,
    required this.position,
    required this.intensity,
    required this.value,
  });

  List<CountryData> loadHeatMapData() {
    return [
      CountryData(
        countryCode: 'US',
        position: LatLng(37.7749, -122.4194), // San Francisco
        intensity: 0.8,
        value: 19870,
      ),
      CountryData(
        countryCode: 'CN',
        position: LatLng(39.9042, 116.4074), // Beijing
        intensity: 0.7,
        value: 4900,
      ),
      // Add more countries...
    ];
  }
}
