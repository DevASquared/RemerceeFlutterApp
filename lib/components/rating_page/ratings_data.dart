import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'stars_rating.dart';

class RatingsData extends StatefulWidget {
  final double meanRate;
  final double rateNumber;

  const RatingsData({
    Key? key,
    required this.meanRate,
    required this.rateNumber,
  }) : super(key: key);

  @override
  State<RatingsData> createState() => _RatingsDataState();
}

class _RatingsDataState extends State<RatingsData> {
  @override
  Widget build(BuildContext context) {
    final meanRate = widget.meanRate;
    final rateNumber = widget.rateNumber;
    final width = MediaQuery.of(context).size.width;
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    List<FlSpot> spots = [
      const FlSpot(0, 0),
      const FlSpot(1, 4.2),
      const FlSpot(2, 4.5),
      const FlSpot(3, 4),
      const FlSpot(4, 4.6),
    ];

    return /*spots.isEmpty ? Container() :*/ Column(
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
                          gridData: FlGridData(show: false),
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
