import 'dart:developer';

import 'package:client_nfc_mobile_app/utils/country_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  double _zoomLevel = 3.0; // Initial zoom level
  final double _zoomIncrement = 1.0;
  final double _zoomDecrement = 1.0;

  @override
  void initState() {
    super.initState();
    _fetchGeoData();
  }

  _fetchGeoData() async {
    var pro = context.read<GeoProvider>();
    final geoData = await pro.fetchGeoViewData(widget.auth_token);

    final coloredCountries = <String, Color>{};
    if (geoData != null && geoData.isNotEmpty) {
      // Process the geoData if it's not empty
      for (var item in geoData) {
        final location = item['location'] as String;
        final count = item['count'] as int;

        // Determine color based on count
        Color color;
        if (count > 0) {
          color =
              CountryColors.colors[location] ?? Colors.grey; // Default color
        } else {
          color = Colors.grey; // No data or not colored
        }

        coloredCountries[location] = color;
      }
    } else {
      // Handle the case where geoData is empty
      coloredCountries.clear(); // No country will be colored
    }

    // Convert coloredCountries to MapModel list
    final List<MapModel> mapData = coloredCountries.entries.map((entry) {
      return MapModel(
        state: entry.key,
        color: entry.value,
      );
    }).toList();

    setState(() {
      _mapData = mapData;
      _shapeSource = MapShapeSource.asset(
        'assets/map_json/world-map.json',
        shapeDataField: 'cc',
        dataCount: _mapData!.length,
        primaryValueMapper: (int index) => _mapData![index].state,
        shapeColorValueMapper: (int index) => _mapData![index].color,
      );
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
              child: CircularProgressIndicator.adaptive(),
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
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "Our most customers in US",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.1,
                                color: Color(0XFF696974),
                              ),
                            ),
                          ],
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
                                    SizedBox(width: 10),
                                    Text(
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
                                  "15.7k",
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
                                        color: Color(0XFFFF974A),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
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
                                  "4.9k",
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
                                        color: Color(0XFFFFC542),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
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
                                  "2.4k",
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
                                    SizedBox(width: 10),
                                    Text(
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
                                  "980",
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
                                    child: Icon(
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
                                    child: Icon(
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
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            SizedBox(width: 10),
                            Text(
                              "Customer",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.1,
                                color: Color(0XFF0062FF),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Color(0XFF8B8B8B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "No customer",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.1,
                                color: Color(0XFF8B8B8B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
