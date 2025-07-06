import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'monitor_page.dart';

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({super.key});

  @override
  State<SensorDataPage> createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  double temperature = 0;
  int soil = 0;
  int water = 0;

  late DatabaseReference sensorRef;

  @override
  void initState() {
    super.initState();
    sensorRef = FirebaseDatabase.instance.ref().child('sensor');
    sensorRef.onValue.listen((event) {
      print(
        'Firebase snapshot: ${event.snapshot.value}',
      ); // <-- This prints every update
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          temperature = (data['temperature'] ?? 0).toDouble();
          soil = data['soil'] ?? 0;
          water = data['water'] ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
      'Building MonitorPage with: soil=$soil, water=$water, temp=$temperature',
    );
    return MonitorPage(
      soilHumidity: soil,
      waterLevel: water,
      temperature: temperature.round(),
    );
  }
}
