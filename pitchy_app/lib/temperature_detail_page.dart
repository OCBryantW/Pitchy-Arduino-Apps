import 'package:flutter/material.dart';

class TemperatureDetailPage extends StatelessWidget {
  final int temperature;

  const TemperatureDetailPage({super.key, required this.temperature});

  String getTemperatureStatus(int value) {
    if (value < 15) return "Terlalu Dingin";
    if (value < 25) return "Sejuk";
    if (value <= 30) return "Ideal";
    if (value <= 35) return "Hangat";
    return "Terlalu Panas";
  }

  Color getStatusColor(int value) {
    if (value < 15) return Colors.blue;
    if (value < 25) return Colors.cyan;
    if (value <= 30) return Colors.green;
    if (value <= 35) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final status = getTemperatureStatus(temperature);
    final statusColor = getStatusColor(temperature);

    return Scaffold(
      backgroundColor: const Color(0xFF171E22),
      body: SafeArea(
        child: Column(
          children: [
            // Back arrow
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 10, left: 12, bottom: 10),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            // Main Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F1EA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperature",
                        style: TextStyle(
                          color: Color(0xFF53B316),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _CustomTemperatureGaugeBar(
                        value: temperature,
                        statusColor: statusColor,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "$temperature°C",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Tahukah kamu?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Suhu ideal sangat penting untuk pertumbuhan tanaman. Suhu terlalu rendah memperlambat metabolisme, sedangkan suhu terlalu tinggi bisa menyebabkan stress tanaman.",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom gauge bar for temperature
class _CustomTemperatureGaugeBar extends StatelessWidget {
  final int value;
  final Color statusColor;
  const _CustomTemperatureGaugeBar({
    required this.value,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelFraction = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
    final labelTexts = ['10', '15', '20', '25', '30', '35'];
    final barHeight = 24.0;
    final barRadius = 12.0;
    final barWidth = MediaQuery.of(context).size.width - 48.0;

    return SizedBox(
      width: barWidth,
      height: 70,
      child: Stack(
        children: [
          Row(
            children: [
              // Blue (very cold)
              Expanded(
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(barRadius),
                    ),
                  ),
                ),
              ),
              // Cyan (cool)
              Expanded(child: Container(height: barHeight, color: Colors.cyan)),
              // Green (ideal)
              Expanded(
                child: Container(height: barHeight, color: Colors.green),
              ),
              // Orange (warm)
              Expanded(
                child: Container(height: barHeight, color: Colors.orange),
              ),
              // Red (very hot)
              Expanded(
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(barRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -18,
            left: ((value - 10).clamp(0, 25) / 25.0) * (barWidth - 24),
            child: Icon(Icons.arrow_drop_down, color: statusColor, size: 40),
          ),
          // Labels
          ...List.generate(labelFraction.length, (i) {
            final left = labelFraction[i] * (barWidth - 20);
            return Positioned(
              left: left,
              bottom: 10, // adjust gap as needed
              child: Text(
                labelTexts[i],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
