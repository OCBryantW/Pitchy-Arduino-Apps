import 'package:flutter/material.dart';
import 'sensor_data_page.dart'; // <- Import your real-time updating page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171E22), // dark background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 30, bottom: 10),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Good Morning,\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "GLEEN",
                      style: TextStyle(
                        color: Color(0xFF53B316),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Healthy Plants Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Quote
                    Expanded(
                      child: Text(
                        '"Healthy Plants\nHealthy World"',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Plant icon (using Flutter built-in icon for MVP)
                    Icon(
                      Icons.local_florist,
                      size: 48,
                      color: Color(0xFF53B316),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            // Main white rounded section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F1EA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Farm List
                      const Text(
                        "Farm List",
                        style: TextStyle(
                          color: Color(0xFFB6BB9B),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Farm Card (tap to open SensorDataPage)
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SensorDataPage(),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                // Profile image (placeholder)
                                CircleAvatar(
                                  radius: 23,
                                  backgroundImage: NetworkImage(
                                    "https://randomuser.me/api/portraits/men/32.jpg",
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Field Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Pitchy Field 1",
                                        style: TextStyle(
                                          color: Color(0xFF53B316),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "Ngaliyan, Semarang",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Condition: ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "Bad",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                247,
                                                32,
                                                32,
                                              ),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // You can add more farm fields/cards here if needed!
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
