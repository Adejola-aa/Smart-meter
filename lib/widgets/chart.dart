import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class LivePowerChart extends StatelessWidget {
  const LivePowerChart({
    required this.power,
    required this.powerSpots,
    super.key,
  });
  final double power;
  final List<FlSpot> powerSpots;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 16, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: Row(
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
                    "Power",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: power.toStringAsFixed(1),
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: " W  ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.none(),
                  minX: powerSpots.isNotEmpty ? powerSpots.first.x : 0,
                  maxX: powerSpots.isNotEmpty ? powerSpots.last.x : 10,
                  minY: 0,
                  maxY: 600,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Voltage (V)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Current (A)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.transparent),
                      top: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: powerSpots,
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

class LiveEnergyChart extends StatelessWidget {
  const LiveEnergyChart({
    required this.energy,
    required this.energySpots,
    super.key,
  });
  final double energy;
  final List<FlSpot> energySpots;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: Row(
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
                    "Energy",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: energy.toStringAsFixed(1),
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: " KW/h  ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.none(),
                  minX: energySpots.isNotEmpty ? energySpots.first.x : 0,
                  maxX: energySpots.isNotEmpty ? energySpots.last.x : 10,
                  minY: 0,
                  maxY: 600,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Power (W)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Time (s)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.transparent),
                      top: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: energySpots,
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
