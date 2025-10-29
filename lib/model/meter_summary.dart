class MeterSummary {
  MeterSummary({
    required this.avgPower,
    required this.peakPower,
    required this.energyKwh,
    required this.peakUsage,
  });

  final double avgPower;
  final double peakPower;
  final double energyKwh;
  final DateTime peakUsage;
}
