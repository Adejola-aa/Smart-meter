import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_meter/model/meter_reading.dart';

class MeterData {
  Future<MeterReading> fetchLatestReading() async {
    final client = http.Client();
    final uri = Uri.parse('https://meterryapis.onrender.com/meter/live');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MeterReading.fromJson(data);
    } else {
      throw Exception('Failed to fetch meter reading');
    }
  }

  Future<List<MeterReading>> fetchHistory() async {
    final client = http.Client();
    final uri = Uri.parse('https://meterryapis.onrender.com/meter/history');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => MeterReading.fromJson(item)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
