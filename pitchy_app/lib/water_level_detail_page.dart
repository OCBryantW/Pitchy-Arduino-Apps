import 'package:flutter/material.dart';

class WaterLevelDetailPage extends StatelessWidget {
  final int waterLevel;

  const WaterLevelDetailPage({super.key, required this.waterLevel});

  String getWaterStatus(int value) {
    if (value < 20) return "Kekeringan";
    if (value < 40) return "Kurang";
    if (value <= 80) return "Cukup";
    return "Terlalu Banyak";
  }

  Color getStatusColor(int value) {
    if (value < 20) return Colors.red;
    if (value < 40) return Colors.yellow[700]!;
    if (value <= 80) return Colors.green;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final status = getWaterStatus(waterLevel);
    final statusColor = getStatusColor(waterLevel);

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
                        "Water Level",
                        style: TextStyle(
                          color: Color(0xFF53B316),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _CustomWaterLevelGaugeBar(
                        value: waterLevel,
                        statusColor: statusColor,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "$waterLevel%",
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
                                "Tingkat air yang cukup penting untuk mendukung pertumbuhan dan kesehatan tanaman. Kekurangan atau kelebihan air dapat menyebabkan gangguan pada tanaman.",
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

// Custom gauge bar for water level
class _CustomWaterLevelGaugeBar extends StatelessWidget {
  final int value;
  final Color statusColor;
  const _CustomWaterLevelGaugeBar({
    required this.value,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelFraction = [0.0, 0.19, 0.4, 0.61, 0.82, 0.98];
    final labelTexts = ['0', '20', '40', '60', '80', '100'];
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
              // Red (very low)
              Expanded(
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(barRadius),
                    ),
                  ),
                ),
              ),
              // Yellow (low)
              Expanded(
                child: Container(height: barHeight, color: Colors.yellow[700]),
              ),
              // Green (ideal)
              Expanded(
                child: Container(height: barHeight, color: Colors.green),
              ),
              // Yellow (high)
              Expanded(
                child: Container(height: barHeight, color: Colors.yellow[700]),
              ),
              // Blue (very high)
              Expanded(
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
            left: (value.clamp(0, 100) / 100.0) * (barWidth - 24),
            child: Icon(Icons.arrow_drop_down, color: statusColor, size: 40),
          ),
          ...List.generate(labelFraction.length, (i) {
            final left = labelFraction[i] * (barWidth - 20);
            return Positioned(
              left: left,
              bottom: 10,
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
