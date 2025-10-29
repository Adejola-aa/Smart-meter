class MeterReading {
  const MeterReading({
    required this.voltage,
    required this.current,
    required this.power,
    required this.energy,
    required this.timestamp,
  });

  final double voltage;
  final double current;
  final double power;
  final double energy;
  final DateTime timestamp;

  factory MeterReading.fromJson(Map<String, dynamic> json) {
    return MeterReading(
      voltage: (json['voltage'] as num).toDouble(),
      current: (json['current'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      energy: (json['energy'] as num).toDouble(),
      timestamp: DateTime.parse(json['time_stamp'] as String),
    );
  }
}
