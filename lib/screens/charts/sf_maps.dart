import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class SFMAPScreen extends StatefulWidget {
  const SFMAPScreen({super.key});

  @override
  State<SFMAPScreen> createState() => _SFMAPScreenState();
}

class _SFMAPScreenState extends State<SFMAPScreen> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
  late MapZoomPanBehavior _zoomPanBehavior;
  bool _isMapLoaded = false;
  String? _hoveredCountry;
  Color? _hoveredColor;
  double _zoomLevel = 3.0; // Initial zoom level
  final double _zoomIncrement = 1.0;
  final double _zoomDecrement = 1.0;
  @override
  void initState() {
    super.initState();

    // Define the countries you want to color
    final coloredCountries = {
      'Afghanistan': Colors.red,
      'Angola': Colors.blue,
      'Pakistan': Colors.green
      // Add more countries and their respective colors here
    };

    _mapData = _getMapData(coloredCountries);

    _shapeSource = MapShapeSource.asset(
      'assets/map_json/world-map.json',
      shapeDataField: 'admin',
      dataCount: _mapData.length,
      primaryValueMapper: (int index) => _mapData[index].state,
      shapeColorValueMapper: (int index) => _mapData[index].color,
    );

    _zoomPanBehavior = MapZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      maxZoomLevel: 10,
      zoomLevel: _zoomLevel,
    );
  }

  List<MapModel> _getMapData(Map<String, Color> coloredCountries) {
    return coloredCountries.entries.map((entry) {
      return MapModel(state: entry.key, color: entry.value);
    }).toList();
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + _zoomIncrement).clamp(1.0, 10.0);
      _zoomPanBehavior.zoomLevel = _zoomLevel;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - _zoomDecrement).clamp(1.0, 10.0);
      _zoomPanBehavior.zoomLevel = _zoomLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: SfMaps(
                  layers: [
                    MapShapeLayer(
                      source: _shapeSource,
                      zoomPanBehavior: _zoomPanBehavior,
                      strokeWidth: 1,
                      strokeColor: Colors.black12,
                      showDataLabels: false,
                      onSelectionChanged: (int index) {
                        if (index != -1) {
                          setState(() {
                            _hoveredCountry = _mapData[index].state;
                            _hoveredColor = _mapData[index].color;
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
                      style: TextStyle(fontSize: 16, color: Colors.black87),
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
                    // Row(
                    //   children: [
                    //     Text(
                    //       "19.870",
                    //       style: TextStyle(
                    //         fontFamily: "GothamBold",
                    //         fontSize: 28.0,
                    //         fontWeight: FontWeight.w700,
                    //         color: Color(0XFF171725),
                    //       ),
                    //     ),
                    //     SizedBox(width: 2),
                    //     Image.asset(
                    //       "assets/images/US.png",
                    //       width: 28,
                    //       height: 20,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ],
                    // ),

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
            SizedBox(height: 17),
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
          ],
        ),
      ),
    );
  }
}

class MapModel {
  MapModel({required this.state, required this.color});

  final String state;
  final Color color;
}
