import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_meter/widgets/chart.dart';
import 'package:smart_meter/widgets/analytics_card.dart';
import 'package:smart_meter/providers/meter_provider.dart';
import 'package:smart_meter/providers/chart_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestReading = ref.watch(meterDataProvider);
    final energySpots = ref.watch(energyChartProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Energy Data Visualization",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              LiveEnergyChart(
                energy: latestReading?.energy ?? 0,
                energySpots: energySpots,
              ),
              AnalyticsCard(
                title: 'Average Power',
                subtitle: 'Power',
                summaryData: 60,
              ),
              const SizedBox(height: 6),
              AnalyticsCard(
                title: 'Peak Usage',
                subtitle: 'Energy',
                summaryData: 60,
              ),
              const SizedBox(height: 6),
              AnalyticsCard(
                title: 'Energy Consumed',
                subtitle: 'Cost',
                summaryData: 60,
              ),
              const SizedBox(height: 6),
              AnalyticsCard(title: 'data', subtitle: 'data', summaryData: 60),
              const SizedBox(height: 6),
              AnalyticsCard(title: 'data', subtitle: 'data', summaryData: 60),
              const SizedBox(height: 6),
              AnalyticsCard(title: 'data', subtitle: 'data', summaryData: 60),
            ],
          ),
        ),
      ),
    );
  }
}
