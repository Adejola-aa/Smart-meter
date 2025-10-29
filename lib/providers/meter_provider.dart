import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_meter/model/meter_reading.dart';
import 'package:smart_meter/services/meter_data.dart';

class MeterNotifier extends StateNotifier<MeterReading?> {
  final MeterData meterData;
  Timer? _timer;
  MeterNotifier(this.meterData) : super(null) {
    _startPolling();
  }

  void _startPolling() {
    _fetchMeterData();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => _fetchMeterData(),
    );
  }

  Future<void> _fetchMeterData() async {
    try {
      final data = await meterData.fetchLatestReading();
      state = data;
    } catch (e) {
      Exception('Failed to fetch meter reading $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final meterProvider = Provider<MeterData>((ref) => MeterData());

final meterDataProvider = StateNotifierProvider<MeterNotifier, MeterReading?>(
  (ref) => MeterNotifier(ref.read(meterProvider)),
);

final historyDataProvider = FutureProvider<List<MeterReading>>((ref) async {
  return ref.watch(meterProvider).fetchHistory();
});
