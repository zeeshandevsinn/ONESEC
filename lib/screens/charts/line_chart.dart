import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InteractionFrequencyChart extends StatefulWidget {
  @override
  State<InteractionFrequencyChart> createState() =>
      _InteractionFrequencyChartState();
}

class _InteractionFrequencyChartState extends State<InteractionFrequencyChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Mon';
                      break;
                    case 1:
                      text = 'Tue';
                      break;
                    case 2:
                      text = 'Wed';
                      break;
                    case 3:
                      text = 'Thu';
                      break;
                    case 4:
                      text = 'Fri';
                      break;
                    case 5:
                      text = 'Sat';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(text, style: style),
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
                  String text;
                  if (value == 0) {
                    text = '\$0';
                  } else if (value == 250) {
                    text = '\$250';
                  } else if (value == 500) {
                    text = '\$500';
                  } else if (value == 750) {
                    text = '\$750';
                  } else if (value == 1000) {
                    text = '\$1k';
                  } else {
                    text = '';
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(text, style: style),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 1000,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 700),
                FlSpot(1, 900),
                FlSpot(2, 800),
                FlSpot(3, 850),
                FlSpot(4, 950),
                FlSpot(5, 1000),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.red.withOpacity(0.1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
