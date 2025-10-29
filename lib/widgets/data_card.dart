import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class CurrentCard extends StatelessWidget {
  const CurrentCard({
    required this.current,
    required this.currentSpots,
    super.key,
  });
  final double current;
  final List<FlSpot> currentSpots;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width / 18,
                  backgroundColor: Color.fromRGBO(24, 160, 251, 0.12),
                  child: Icon(
                    CupertinoIcons.bolt,
                    color: Color.fromRGBO(24, 160, 251, 1),
                    size: size.width / 12,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "Current",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: current.toStringAsFixed(1),
                style: TextStyle(
                  // color: const Color.fromRGBO(31, 31, 31, 1),
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: " A  ",
                    style: TextStyle(
                      color: Colors.black87,
                      // color: const Color.fromRGBO(31, 31, 31, 1),
                      fontFamily: 'Poppins',
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.none(),
                  minX: currentSpots.isNotEmpty ? currentSpots.first.x : 0,
                  maxX: currentSpots.isNotEmpty ? currentSpots.last.x : 1,
                  minY: 0,
                  maxY: 40,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentSpots,
                      isCurved: true,
                      color: Colors.blue[500],
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color.fromARGB(150, 227, 242, 253),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoltageCard extends StatelessWidget {
  const VoltageCard({
    required this.voltage,
    required this.voltageSpots,
    super.key,
  });
  final double voltage;
  final List<FlSpot> voltageSpots;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width / 18,
                  backgroundColor: Color.fromRGBO(24, 160, 251, 0.12),
                  child: Icon(
                    CupertinoIcons.bolt,
                    color: Color.fromRGBO(24, 160, 251, 1),
                    size: size.width / 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Voltage",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            RichText(
              text: TextSpan(
                text: voltage.toStringAsFixed(1),
                style: TextStyle(
                  // color: const Color.fromRGBO(31, 31, 31, 1),
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: " V  ",
                    style: TextStyle(
                      color: Colors.black87,
                      // color: const Color.fromRGBO(31, 31, 31, 1),
                      fontFamily: 'Poppins',
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.none(),
                  minX: voltageSpots.isNotEmpty ? voltageSpots.first.x : 0,
                  maxX: voltageSpots.isNotEmpty ? voltageSpots.last.x : 1,
                  minY: 0,
                  maxY: 450,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: voltageSpots,
                      isCurved: true,
                      color: Colors.blue[500], // medium blue
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color.fromARGB(150, 227, 242, 253),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
