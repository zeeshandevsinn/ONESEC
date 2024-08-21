import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PeakInteractionChart extends StatefulWidget {
  final String timeScale;

  PeakInteractionChart({required this.timeScale});

  @override
  State<PeakInteractionChart> createState() => _PeakInteractionChartState();
}

class _PeakInteractionChartState extends State<PeakInteractionChart> {
  List<BarChartGroupData> _getBarGroups() {
    switch (widget.timeScale) {
      case 'Monthly':
        return List.generate(6, (index) {
          return makeGroupData(index, (index + 1) * 10.0, (index + 2) * 10.0);
        });
      case 'Weekly':
        return List.generate(7, (index) {
          return makeGroupData(index, (index + 1) * 5.0, (index + 2) * 5.0);
        });
      case 'Daily':
        return List.generate(7, (index) {
          return makeGroupData(index, (index + 1) * 3.0, (index + 2) * 3.0);
        });
      default:
        return [];
    }
  }

  List<String> _getBottomTitles() {
    switch (widget.timeScale) {
      case 'Monthly':
        return [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          // 'Jul',
          // 'Aug',
          // 'Sep',
          // 'Oct',
          // 'Nov',
          // 'Dec'
        ];
      case 'Weekly':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'Daily':
        return List.generate(7, (index) => (index + 1).toString());
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 200,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  String text = _getBottomTitles()[value.toInt()];
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
          barGroups: _getBarGroups(),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
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
