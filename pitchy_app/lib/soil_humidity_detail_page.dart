import 'package:flutter/material.dart';

class SoilHumidityDetailPage extends StatelessWidget {
  final int soilHumidity;

  const SoilHumidityDetailPage({super.key, required this.soilHumidity});

  String getSoilStatus(int value) {
    if (value < 20) return "Terlalu Kering";
    if (value < 40) return "Kurang";
    if (value <= 60) return "Excellent";
    if (value <= 80) return "Cukup";
    return "Terlalu Basah";
  }

  Color getStatusColor(int value) {
    if (value < 20) return Colors.red;
    if (value < 40) return Colors.yellow[700]!;
    if (value <= 60) return Colors.green;
    if (value <= 80) return Colors.yellow[700]!;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final status = getSoilStatus(soilHumidity);
    final statusColor = getStatusColor(soilHumidity);

    return Scaffold(
      backgroundColor: const Color(0xFF171E22),
      body: SafeArea(
        child: Column(
          children: [
            // Top: Back arrow only
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
                      // Title now in the white area
                      Text(
                        "Soil Humidity",
                        style: TextStyle(
                          color: Color(0xFF53B316),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Gauge bar with pointer & labels using Canvas
                      _CustomGaugeBar(
                        value: soilHumidity,
                        statusColor: statusColor,
                      ),
                      const SizedBox(height: 24),
                      // Big value
                      Text(
                        soilHumidity.toString(),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      // Status below value
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 36),
                      // "Tahukah kamu?" info card
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
                                "Kelembapan tanah yang ideal sangat penting untuk memastikan akar tanaman bisa menyerap air dan nutrisi dengan maksimal.\n\n"
                                "Jika terlalu kering, tanaman bisa layu dan berhenti tumbuh. Sebaliknya, jika terlalu basah, akar bisa membusuk.\n\n"
                                "Dengan memonitor soil humidity secara real-time, kamu bisa menjaga kesehatan tanaman dan menghemat air secara efisien 🌱💧",
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

// Custom gauge widget with precise label placement
class _CustomGaugeBar extends StatelessWidget {
  final int value;
  final Color statusColor;
  const _CustomGaugeBar({required this.value, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    // Fraction for each label (0, 20, 40, 60, 80, 100)
    final labelFraction = [0.2, 0.4, 0.6, 0.8];
    final labelTexts = ['20', '40', ' 60', '  80'];
    final barHeight = 24.0;
    final barRadius = 12.0;
    final barWidth =
        MediaQuery.of(context).size.width - 48.0; // 24 padding left/right

    return SizedBox(
      width: barWidth,
      height: 70,
      child: Stack(
        children: [
          // Gauge bar
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
              // Red (very high)
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
          // Pointer arrow
          Positioned(
            top: -18,
            left:
                (value.clamp(0, 100) / 100.0) *
                (barWidth - 24), // 24 = fudge to align icon visually
            child: Icon(Icons.arrow_drop_down, color: statusColor, size: 40),
          ),
          // Labels (absolutely positioned for precision)
          ...List.generate(labelFraction.length, (i) {
            final left =
                labelFraction[i] *
                (barWidth - 20); // adjust -20 as needed for fine-tuning
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
