// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../../utils/toast.dart';

// class PeakInteractionChart extends StatefulWidget {
//   final String timescale;
//   final String auth_token;

//   PeakInteractionChart({required this.timescale, required this.auth_token});

//   @override
//   State<PeakInteractionChart> createState() => _PeakInteractionChartState();
// }

// class _PeakInteractionChartState extends State<PeakInteractionChart> {
//   late Future<List<BarChartGroupData>> _barGroupsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _barGroupsFuture = _fetchInteractionData();
//   }

//   Future<List<BarChartGroupData>> _fetchInteractionData() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://api.onesec.shop/api/interaction-frequency/${widget.timescale}/'),
//       headers: {
//         'Authorization': 'Token ${widget.auth_token}',
//       },
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return _parseBarGroups(data);
//     } else {
//       MyToast('Failed to load interaction data', Type: false);
//       return [];
//     }
//   }

//   List<BarChartGroupData> _parseBarGroups(List<dynamic> data) {
//     return List.generate(data.length, (index) {
//       final item = data[index];
//       return makeGroupData(
//           index, item['count'].toDouble(), item['count'].toDouble() * 10.0);
//     });
//   }

//   List<String> _getBottomTitles() {
//     List<String> titles;
//     switch (widget.timescale) {
//       case 'monthly':
//         titles = [
//           'Jan',
//           'Feb',
//           'Mar',
//           'Apr',
//           'May',
//           'Jun',
//           'Jul',
//           'Aug',
//           'Sep',
//           'Oct',
//           'Nov',
//           'Dec'
//         ];
//         break;
//       case 'weekly':
//         titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//         break;
//       case 'daily':
//         titles = List.generate(24, (index) => (index + 1).toString());
//         break;
//       default:
//         titles = [];
//     }

//     // Show every other title if the list is too long
//     if (titles.length > 12) {
//       titles = List.generate(titles.length ~/ 2, (index) => titles[index * 2]);
//     }
//     return titles;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           height: constraints.maxHeight * 0.8,
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: FutureBuilder<List<BarChartGroupData>>(
//             future: _barGroupsFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 print(snapshot.error);
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No data available'));
//               } else {
//                 final dataBars = snapshot.data!;
//                 final titles = _getBottomTitles();
//                 return FractionallySizedBox(
//                   widthFactor: 1.0,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: BarChart(
//                       BarChartData(
//                         alignment: BarChartAlignment.spaceAround,
//                         maxY: 200,
//                         barTouchData: BarTouchData(enabled: false),
//                         titlesData: FlTitlesData(
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               reservedSize: 40,
//                               getTitlesWidget: (value, meta) {
//                                 final index = value.toInt();
//                                 final title =
//                                     titles.isNotEmpty && index < titles.length
//                                         ? titles[index]
//                                         : '';
//                                 return SideTitleWidget(
//                                   axisSide: meta.axisSide,
//                                   child: Text(
//                                     title,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               reservedSize: 40,
//                               getTitlesWidget: (value, meta) {
//                                 final style = TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 12,
//                                 );
//                                 return SideTitleWidget(
//                                   axisSide: meta.axisSide,
//                                   child: Text(value.toString(), style: style),
//                                 );
//                               },
//                             ),
//                           ),
//                           rightTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false),
//                           ),
//                           topTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false),
//                           ),
//                         ),
//                         borderData: FlBorderData(show: false),
//                         barGroups: dataBars,
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// BarChartGroupData makeGroupData(int x, double y1, double y2) {
//   return BarChartGroupData(
//     barsSpace: 4,
//     x: x,
//     barRods: [
//       BarChartRodData(
//         toY: y1,
//         color: Colors.blueAccent,
//         width: 10,
//       ),
//       BarChartRodData(
//         toY: y2,
//         color: Colors.redAccent,
//         width: 10,
//       ),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/toast.dart';

class PeakInteractionChart extends StatefulWidget {
  final String timescale;
  final String auth_token;

  PeakInteractionChart({required this.timescale, required this.auth_token});

  @override
  State<PeakInteractionChart> createState() => _PeakInteractionChartState();
}

class _PeakInteractionChartState extends State<PeakInteractionChart> {
  late Future<List<BarChartGroupData>> _barGroupsFuture;

  @override
  void initState() {
    super.initState();
    _barGroupsFuture = _fetchInteractionData();
  }

  Future<List<BarChartGroupData>> _fetchInteractionData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.onesec.shop/api/interaction-frequency/${widget.timescale}/'),
      headers: {
        'Authorization': 'Token ${widget.auth_token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return _parseBarGroups(data);
    } else {
      MyToast('Failed to load interaction data', Type: false);
      return [];
    }
  }

  List<BarChartGroupData> _parseBarGroups(List<dynamic> data) {
    return List.generate(data.length, (index) {
      final item = data[index];
      return makeGroupData(
          index, item['count'].toDouble(), item['count'].toDouble() * 10.0);
    });
  }

  List<String> _getBottomTitles() {
    List<String> titles;
    switch (widget.timescale) {
      case 'monthly':
        titles = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        break;
      case 'weekly':
        titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        break;
      case 'daily':
        titles = List.generate(24, (index) => (index + 1).toString());
        break;
      default:
        titles = [];
    }

    // Show every title
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FutureBuilder<List<BarChartGroupData>>(
            future: _barGroupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final dataBars = snapshot.data!;
                final titles = _getBottomTitles();
                final dynamicWidth = titles.length * 60.0;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: dynamicWidth, // Set dynamic width
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 200,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                final title =
                                    titles.isNotEmpty && index < titles.length
                                        ? titles[index]
                                        : '';
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                final style = TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                );
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(value.toString(), style: style),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: dataBars,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(
    barsSpace: 2,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.blueAccent,
        width: 10,
      ),
      BarChartRodData(
        toY: y2,
        color: Colors.redAccent,
        width: 10,
      ),
    ],
  );
}
