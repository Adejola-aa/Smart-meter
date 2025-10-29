import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    required this.title,
    required this.subtitle,
    required this.summaryData,
    super.key,
  });

  final String title;
  final String subtitle;
  final Object? summaryData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          radius: size.width / 20,
          backgroundColor: Color.fromRGBO(24, 160, 251, 0.12),
          child: Icon(
            CupertinoIcons.bolt_circle,
            color: Color.fromRGBO(24, 160, 251, 1),
            size: size.width / 12,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoSerif',
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
