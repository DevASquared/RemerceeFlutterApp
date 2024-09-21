import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import './StarsRating.dart';

class RatingsData extends StatefulWidget {
  final double meanRate;
  final double rateNumber;

  const RatingsData({
    Key? key,
    required this.meanRate,
    required this.rateNumber,
  }) : super(key: key);

  @override
  State<RatingsData> createState() => _ratingsDataState();
}

class _ratingsDataState extends State<RatingsData> {
  @override
  Widget build(BuildContext context) {
    final meanRate = widget.meanRate;
    final rateNumber = widget.rateNumber;
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Text(
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
                  meanRate.toString(),
                  style: TextStyle(
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StarsRating(rate: meanRate),
                Row(
                  children: [
                    Text(
                      "Nombre de notes : ",
                      style: TextStyle(
                        fontSize: width * 0.05,
                      ),
                    ),
                    Text(
                      rateNumber.toString(),
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFEA2831),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.4, // définir la hauteur
                  width: width, // prendre toute la largeur disponible
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return Text('Jan');
                                case 1:
                                  return Text('Feb');
                                case 2:
                                  return Text('Mar');
                                case 3:
                                  return Text('Apr');
                                case 4:
                                  return Text('May');
                                default:
                                  return Container();
                              }
                            },
                            interval: 1,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3.7),
                            FlSpot(1, 4.2),
                            FlSpot(2, 4.5),
                            FlSpot(3, 4),
                            FlSpot(4, 4.6),
                          ],
                          isCurved: true,
                          barWidth: 4,
                          color: Color(0xFF737373),
                          belowBarData: BarAreaData(show: true),
                          dotData: FlDotData(show: false), // Désactive les points
                        ),
                      ],
                      minY: 0, // Limite inférieure
                      maxY: 5, // Limite supérieure
                    ),
                  )

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
