import 'package:covid_19/constants/constants.dart';

import 'package:covid_19/models/country_summary.dart';
import 'package:covid_19/models/time_serise_cases.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19/screens/chart.dart';
import 'package:flutter/material.dart';

class CountryStatistics extends StatelessWidget {
  final List<CountrySummaryModel> summaryList;
  CountryStatistics({@required this.summaryList});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCard(
          "ຈຳນວນຜູ້ຕິດເຊື້ອທັງໝົດ",
          summaryList[summaryList.length - 1].confirmed,
          kConfirmedColor,
          "ກຳລັງປີ່ນປົວຢູ່",
          summaryList[summaryList.length - 1].active,
          kActiveColor,
        ),
        buildCard(
          "ຈຳນວນທີ່ປົວດີແລ້ວ",
          summaryList[summaryList.length - 1].recovered,
          kConfirmedColor,
          "ຈຳນວນເສຍຊີວິດ",
          summaryList[summaryList.length - 1].death,
          kActiveColor,
        ),
        buildCartChart(summaryList),
      ],
    );
  }

  Widget buildCard(String leftTile, int leftValue, Color leftColor,
      String rightTitle, int rightValue, Color rightColor) {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftTile,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Expanded(child: Container()),
                Text(
                  "Total",
                  style: TextStyle(
                      color: leftColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Text(
                  leftValue.toString().replaceAllMapped(reg, mathFunc) + " ຄົນ",
                  style: TextStyle(
                      color: leftColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rightTitle,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Expanded(child: Container()),
                Text(
                  "Total",
                  style: TextStyle(
                      color: rightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Text(
                  rightValue.toString().replaceAllMapped(reg, mathFunc) +
                      " ຄົນ",
                  style: TextStyle(
                      color: rightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCartChart(List<CountrySummaryModel> summaryList) {
    return Card(
      elevation: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: false,
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(
    List<CountrySummaryModel> summaryList,
  ) {
    List<TimeSeriesCases> confirmedData = [];

    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kConfirmedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      )
    ];
  }
}
