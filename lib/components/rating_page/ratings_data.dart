import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'stars_rating.dart';

class RatingsData extends StatefulWidget {
  const RatingsData({
    Key? key,
  }) : super(key: key);

  @override
  State<RatingsData> createState() => _RatingsDataState();
}

class _RatingsDataState extends State<RatingsData> {
  List<FlSpot> spots = [
    // const FlSpot(0, 0),
    // const FlSpot(1, 4.2),
    // const FlSpot(2, 4.5),
    // const FlSpot(3, 4),
    // const FlSpot(4, 4.6),
  ];

  double averageRate = 0;
  int rateCount = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (preferences) {
        var username = preferences.getString("username")!;
        ApiController.getUserProfileFromUsername(username).then(
          (user) {
            setState(() {
              rateCount = user.notes.length;
              if (rateCount > 0) {
                var notesSum = user.notes.map((e) => e.rate).reduce(
                      (v, e) => v + e,
                    );
                averageRate = notesSum / user.notes.length;
              }
            });
            int i = 0;
            for (double note in user.getNotesSumLast12Months()) {
              if (note != 0) {
                note = double.parse(note.toStringAsFixed(2));
                setState(() {
                  if (user.getNotesSumLast12Months()[i - 1] == 0) {
                    spots.add(FlSpot((i - 3).toDouble(), 0));
                  }
                  spots.add(FlSpot((i - 2).toDouble(), note));
                });
              }
              i++;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    log(spots.toString());
    return spots.isEmpty
        ? Container()
        : Column(
            children: [
              const Text(
                "Récap des notes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: width * 0.07),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Note moyenne",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: width * 0.01),
                    Text(
                      double.parse(averageRate.toStringAsFixed(2)).toString(),
                      style: TextStyle(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StarsRating(rate: averageRate),
                    Row(
                      children: [
                        Text(
                          "Nombre de notes : ",
                          style: TextStyle(
                            fontSize: width * 0.05,
                          ),
                        ),
                        Text(
                          rateCount.toString(),
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEA2831),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.4, // définir la hauteur
                      width: width, // prendre toute la largeur disponible
                      child: spots.isEmpty
                          ? Container()
                          : LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(months[value.toInt()]);
                                      },
                                      interval: spots.length < 4
                                          ? 1
                                          : spots.length < 8
                                              ? 2
                                              : 4,
                                    ),
                                  ),
                                  leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: spots,
                                    isCurved: true,
                                    barWidth: 4,
                                    color: const Color(0xFF737373),
                                    belowBarData: BarAreaData(show: true),
                                    dotData: const FlDotData(show: true),
                                  ),
                                ],
                                minY: 0,
                                maxY: 12, // Limite supérieure
                              ),
                            ),
                    )
                  ],
                ),
              )
            ],
          );
  }
}
