import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InteractionChartWidget extends StatefulWidget {
  final String auth_token;

  InteractionChartWidget({required this.auth_token});

  @override
  _InteractionChartWidgetState createState() => _InteractionChartWidgetState();
}

class _InteractionChartWidgetState extends State<InteractionChartWidget> {
  String _selectedValue = 'daily';
  late Future<List<BarChartGroupData>> _barGroupsFuture;

  @override
  void initState() {
    super.initState();
    _barGroupsFuture = _fetchInteractionData();
  }

  Future<List<BarChartGroupData>> _fetchInteractionData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.onesec.shop/api/interaction-frequency/$_selectedValue/'),
      headers: {
        'Authorization': 'Token ${widget.auth_token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return _parseBarGroups(data);
    } else {
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
    switch (_selectedValue) {
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
        titles = List.generate(31, (index) => (index + 1).toString());
        break;
      default:
        titles = [];
    }

    // if (titles.length > 12) {
    //   titles = List.generate(titles.length ~/ 2, (index) => titles[index * 2]);
    // }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    return _buildChartContainer(
      title: "Peak Interactions Time",
      hint: "Time of Days",
      selectedValue: _selectedValue,
      options: ['daily', 'weekly', 'monthly'],
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue!;
          _barGroupsFuture = _fetchInteractionData();
        });
      },
      chart: FutureBuilder<List<BarChartGroupData>>(
        future: _barGroupsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final dataBars = snapshot.data!;
            final titles = _getBottomTitles();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width:
                    dataBars.length * 60.0, // Adjust width based on data length
                height: 300, // Fixed height for the chart
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
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                value.toString(),
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
  }

  Widget _buildChartContainer({
    required String title,
    required String hint,
    required String? selectedValue,
    required List<String> options,
    required void Function(String?) onChanged,
    required Widget chart,
  }) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Replace with AppColors.containerColor8
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
                title,
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black, // Replace with AppColors.textColor14
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: selectedValue,
                hint: Text(hint),
                style: TextStyle(
                  fontFamily: "GothamRegular",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black, // Replace with AppColors.textColor12
                ),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30,
                  color: Colors.grey, // Replace with AppColors.textColor10
                ),
                iconSize: 24,
                decoration: InputDecoration(
                  fillColor: Colors
                      .grey[200], // Replace with AppColors.containerColor8
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey, // Replace with AppColors.textColor16
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey, // Replace with AppColors.textColor16
                    ),
                  ),
                ),
                onChanged: onChanged,
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24),
            Expanded(child: chart),
          ],
        ),
      ),
    );
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
}
