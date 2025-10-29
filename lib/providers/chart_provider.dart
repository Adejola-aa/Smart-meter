import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/legacy.dart';

class ChartNotifier extends StateNotifier<List<FlSpot>> {
  ChartNotifier() : super([]);

  void addSpot(double value) {
    final x = state.isNotEmpty ? state.last.x + 2.0 : 0.0;
    final newList = [...state, FlSpot(x, value)];

    if (newList.length > 25) {
      newList.removeAt(0);
    }
    state = newList;
  }
}

final currentChartProvider = StateNotifierProvider<ChartNotifier, List<FlSpot>>(
  (ref) => ChartNotifier(),
);

final voltageChartProvider = StateNotifierProvider<ChartNotifier, List<FlSpot>>(
  (ref) => ChartNotifier(),
);

final energyChartProvider = StateNotifierProvider<ChartNotifier, List<FlSpot>>(
  (ref) => ChartNotifier(),
);

final powerChartProvider = StateNotifierProvider<ChartNotifier, List<FlSpot>>(
  (ref) => ChartNotifier(),
);
