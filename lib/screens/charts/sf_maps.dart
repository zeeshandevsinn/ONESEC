import 'dart:developer';

import 'package:client_nfc_mobile_app/utils/country_colors.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:client_nfc_mobile_app/controller/geo_view_data/geo_provider.dart';
import 'package:client_nfc_mobile_app/controller/geo_view_data/geo_view_data.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart'; // Ensure Import the GeoDataService

class SFMAPScreen extends StatefulWidget {
  final String auth_token;
  const SFMAPScreen({super.key, required this.auth_token});

  @override
  State<SFMAPScreen> createState() => _SFMAPScreenState();
}

class _SFMAPScreenState extends State<SFMAPScreen> {
  MapShapeSource? _shapeSource;
  List<MapModel>? _mapData;
  MapZoomPanBehavior? _zoomPanBehavior;
  String? _hoveredCountry;
  Color? _hoveredColor;
  double _zoomLevel = 0.0; // Initial zoom level
  final double _zoomIncrement = 1.0;
  final double _zoomDecrement = 1.0;
  String maxInteraction = "";
  String maxCount = "";
  int massive = 0;
  int large = 0;
  int medium = 0;
  int small = 0;
  @override
  void initState() {
    super.initState();
    _fetchGeoData();
  }

  _fetchGeoData() async {
    var pro = context.read<GeoProvider>();
    final geoData = await pro.fetchGeoViewData(widget.auth_token);

    final coloredCountries = <String, Color>{};
    String? maxInteractionLocation;
    int maxInteractionCount = 0;

    // List to hold counts for further processing
    List<int> counts = [];

    if (geoData != null && geoData.isNotEmpty) {
      for (var item in geoData) {
        final location = item['location'] as String;
        final count = item['count'] as int;

        // Collect counts for sorting and processing
        if (location != 'Unknown') {
          counts.add(count);

          Color color;
          if (count > 0) {
            color = Color(0XFF0062FF); // Default color
          } else {
            color = Colors.grey; // No data or not colored
          }

          coloredCountries[location] = color;

          // Check for maximum interaction
          if (count > maxInteractionCount) {
            maxInteractionCount = count;
            maxInteractionLocation = location;
            maxInteraction =
                "Most Interaction Customer from $maxInteractionLocation";
            maxCount = maxInteractionCount.toString();
          }
        }
      }
    } else {
      // Handle the case where geoData is empty
      coloredCountries.clear(); // No country will be colored
    }

    // Sort counts to find the top three values
    counts.sort((a, b) => b.compareTo(a)); // Sort in descending order

    // Initialize variables

    if (counts.isNotEmpty) {
      // Assign the top three counts
      massive = counts[0];
      if (counts.length > 1) large = counts[1];
      if (counts.length > 2) medium = counts[2];

      // Sum of rest for 'Small'
      if (counts.length > 3) {
        small = counts.skip(3).reduce((a, b) => a + b);
      }
    }

    print('Massive: $massive');
    print('Large: $large');
    print('Medium: $medium');
    print('Small: $small');

    // Convert coloredCountries to MapModel list
    final List<MapModel> mapData = coloredCountries.entries.map((entry) {
      print(entry.value);
      return MapModel(
        state: entry.key,
        color: entry.value,
      );
    }).toList();

    print(mapData);
    if (mounted)
      setState(() {
        _mapData = mapData;
        _hoveredCountry =
            maxInteractionLocation; // Set the location with max interaction
        _shapeSource = mapData.isEmpty
            ? MapShapeSource.asset('assets/map_json/world-map.json')
            : MapShapeSource.asset(
                'assets/map_json/world-map.json',
                // 'assets/map_json/countries.json',
                shapeDataField: 'cc',
                // 'cc',
                dataCount: _mapData!.length,
                primaryValueMapper: (int index) {
                  return _mapData![index].state ?? '';
                },
                shapeColorValueMapper: (int index) => _mapData![index].color,
              );
        // debugger();
        _zoomPanBehavior = MapZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          maxZoomLevel: 10,
          zoomLevel: _zoomLevel,
        );
      });
  }

  void _zoomIn() {
    if (_zoomPanBehavior != null) {
      setState(() {
        _zoomLevel = (_zoomLevel + _zoomIncrement).clamp(1.0, 10.0);
        _zoomPanBehavior!.zoomLevel = _zoomLevel;
      });
    }
  }

  void _zoomOut() {
    if (_zoomPanBehavior != null) {
      setState(() {
        _zoomLevel = (_zoomLevel - _zoomDecrement).clamp(1.0, 10.0);
        _zoomPanBehavior!.zoomLevel = _zoomLevel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var pro = context.watch<GeoProvider>();
      return pro.isLoading
          ? Center(
              child: LoadingCircle(),
            )
          : Container(
              margin: EdgeInsets.all(10),
              height: 600,
              decoration: BoxDecoration(
                color: AppColors.containerColor8,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Text(
                        "Geographic Data Map",
                        style: TextStyle(
                          fontFamily: "GothamBold",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor14,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: Container(
                        height: 400,
                        child: _shapeSource != null && _zoomPanBehavior != null
                            ? SfMaps(
                                layers: [
                                  MapShapeLayer(
                                    source: _shapeSource!,
                                    zoomPanBehavior: _zoomPanBehavior!,
                                    strokeWidth: 1,
                                    strokeColor: Colors.black12,
                                    showDataLabels: false,
                                    onSelectionChanged: (int index) {
                                      if (index != -1) {
                                        setState(() {
                                          _hoveredCountry =
                                              _mapData![index].state;
                                          _hoveredColor =
                                              _mapData![index].color;
                                        });
                                      }
                                    },
                                    tooltipSettings: MapTooltipSettings(
                                      color: Colors.black,
                                    ),
                                    dataLabelSettings: MapDataLabelSettings(
                                      textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                      ),
                                    ),
                                    loadingBuilder: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  "No Interaction is Available.",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ),
                    if (_hoveredCountry != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _hoveredColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              _hoveredCountry!,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * .60,
                              child: GradientText(
                                _mapData!.isEmpty
                                    ? "No Interaction Available!"
                                    : maxInteraction +
                                        '\nTotal People $maxCount',
                                style: TextStyle(
                                  fontFamily: "GothamBold",
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                colors: [
                                  AppColors.textColor1,
                                  AppColors.textColor2,
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: _zoomIn,
                                  child: Container(
                                    height: 34,
                                    width: 34,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.containerColor8,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0XFFE2E2EA),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: Color(0XFFE2E2EA),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 21),
                                GestureDetector(
                                  onTap: _zoomOut,
                                  child: Container(
                                    height: 34,
                                    width: 34,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.containerColor8,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0XFFE2E2EA),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.remove_rounded,
                                      color: Color(0XFFE2E2EA),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(0XFF0062FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Massive",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF44444F),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$massive",
                              style: const TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF44444F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFFF974A),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Large",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF44444F),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$large",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF44444F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFFFC542),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Medium",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF44444F),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$medium",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF44444F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFE2E2EA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Small",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF44444F),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$small",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF44444F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            );
    });
  }
}

class MapModel {
  final String state;
  final Color color;

  MapModel({required this.state, required this.color});
}
