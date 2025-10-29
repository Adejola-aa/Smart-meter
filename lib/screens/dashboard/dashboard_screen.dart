import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_meter/widgets/chart.dart';
import 'package:smart_meter/widgets/data_card.dart';
import 'package:smart_meter/model/meter_reading.dart';
import 'package:smart_meter/providers/chart_provider.dart';
import 'package:smart_meter/providers/meter_provider.dart';
import 'package:smart_meter/providers/user_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Morning";
    if (hour < 17) return "Afternoon";
    return "Evening";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final latestReading = ref.watch(meterDataProvider);
    final currentSpots = ref.watch(currentChartProvider);
    final voltageSpots = ref.watch(voltageChartProvider);
    final powerSpots = ref.watch(powerChartProvider);
    final userAsync = ref.watch(firebaseUserProvider);
    final userImage = ref.watch(userImageProvider);

    ref.listen<MeterReading?>(meterDataProvider, (prev, next) {
      if (next != null) {
        ref.read(currentChartProvider.notifier).addSpot(next.current);
        ref.read(voltageChartProvider.notifier).addSpot(next.voltage);
        ref.read(powerChartProvider.notifier).addSpot(next.power);
        ref.read(energyChartProvider.notifier).addSpot(next.energy);
      }
    });

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromRGBO(24, 160, 251, 0.12),
              backgroundImage: userImage != null
                  ? FileImage(userImage)
                  : const AssetImage("assets/images/light-logo.png")
                        as ImageProvider,
            ),

            const SizedBox(height: 12),
            userAsync.when(
              data: (data) => Text(
                'Good $greeting, \n${data?.userName ?? 'Guest'} ⚡',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              error: (error, e) => Text('Eror: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 5),
            const Text(
              'Welcome to the Smart Meter Dashboard!',
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Last updated: ${latestReading?.timestamp != null ? TimeOfDay.fromDateTime(latestReading!.timestamp).format(context) : 'fetching...'}",
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: VoltageCard(
                    voltage: latestReading?.voltage ?? 0,
                    voltageSpots: voltageSpots,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CurrentCard(
                    current: latestReading?.current ?? 0,
                    currentSpots: currentSpots,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: size.width / 18,
                      backgroundColor: Color.fromRGBO(24, 160, 251, 0.12),
                      child: Icon(
                        CupertinoIcons.antenna_radiowaves_left_right,
                        color: const Color.fromRGBO(0, 167, 167, 1),
                        size: size.width / 12,
                      ),
                    ),
                    SizedBox(width: 45),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Meter Connection State",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              latestReading != null
                                  ? CupertinoIcons.dot_radiowaves_right
                                  : CupertinoIcons.wifi_slash,
                              size: 35,
                              color: latestReading != null
                                  ? const Color.fromRGBO(0, 167, 167, 0.5)
                                  : const Color.fromARGB(232, 255, 82, 82),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              latestReading != null ? "Active" : "Inactive",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'RobotoSerif',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
            Text(
              "Power Data Visualization",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LivePowerChart(
              power: latestReading?.power ?? 0,
              powerSpots: powerSpots,
            ),
          ],
        ),
      ),
    );
  }
}
