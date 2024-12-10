// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PeriodTrendsChart extends StatefulWidget {
  const PeriodTrendsChart({
    super.key,
    this.width,
    this.height,
    required this.userRef,
  });

  final double? width;
  final double? height;
  final DocumentReference userRef;

  @override
  State<PeriodTrendsChart> createState() => _PeriodTrendsChartState();
}

class _PeriodTrendsChartState extends State<PeriodTrendsChart> {
  late Future<List<Map<String, dynamic>>> trendsFuture;

  @override
  void initState() {
    super.initState();
    trendsFuture = fetchCycleLengthTrends(widget.userRef);
  }

  Future<List<Map<String, dynamic>>> fetchCycleLengthTrends(
      DocumentReference userRef) async {
    try {
      // Define the start date (6 months ago)
      final DateTime now = DateTime.now();
      final DateTime sixMonthsAgo = DateTime(now.year, now.month - 5);

      final snapshot = await FirebaseFirestore.instance
          .collection("periodTrack")
          .where("owner", isEqualTo: userRef)
          .where("timeStamp",
              isGreaterThanOrEqualTo: Timestamp.fromDate(sixMonthsAgo))
          .orderBy("timeStamp")
          .get();

      // Map Firestore documents to a list of data points
      return snapshot.docs.map((doc) {
        final data = doc.data();
        final date = (data['timeStamp'] as Timestamp).toDate();
        return {
          "monthYear":
              DateFormat("MMM yyyy").format(date), // Format as "Jan 2024"
          "cycleLength": data["CycleLength"] ?? 0,
        };
      }).toList();
    } catch (e) {
      print("Error fetching cycle length trends: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: trendsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text("No trends available"));
        }

        final trends = snapshot.data!;

        // Create data points for the chart
        List<FlSpot> spots = trends.asMap().entries.map((entry) {
          final index = entry.key.toDouble(); // X-axis is index-based
          final trend = entry.value;
          return FlSpot(index, trend['cycleLength'].toDouble());
        }).toList();

        return Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 300,
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitles: (value) => value
                      .toInt()
                      .toString(), // Display cycle lengths on Y-axis
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    // Map index to month-year labels
                    if (value >= 0 && value < trends.length) {
                      return trends[value.toInt()]['monthYear'];
                    }
                    return '';
                  },
                ),
              ),
              borderData: FlBorderData(show: true),
              minX: 0,
              maxX: trends.length - 1.toDouble(),
              minY: 0, // Adjust based on your data
              maxY: (trends
                      .map((t) => t['cycleLength'] as double)
                      .reduce((a, b) => a > b ? a : b) +
                  5),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
