import 'package:covid_19/constants/constants.dart';
import 'package:covid_19/global_summary.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalStatistics extends StatelessWidget {
  final GlobalSummaryModel summary;

  GlobalStatistics({@required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCard("ຈຳນວນຜູ້ຕິດເຊື້ອທັງໝົດ", summary.totalConfirmed,
            summary.newConfirmed, Colors.red),
        buildCard(
            "ກຳລັງປີ່ນປົວຢູ່",
            summary.totalConfirmed -
                summary.totalRecovered -
                summary.totalDeaths,
            summary.newConfirmed - summary.newRecovered - summary.totalDeaths,
            Colors.blue),
        buildCard("ຈຳນວນທີ່ປົວດີແລ້ວ", summary.totalRecovered,
            summary.newRecovered, Colors.green),
        buildCard("ຈຳນວນເສຍຊີວິດ", summary.totalDeaths, summary.newDeaths,
            kDeathColor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "ອັບແດດສະຖີຕິລ່າສຸດ " + timeago.format(summary.date),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        )
      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color) {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Text(
                      totalCount.toString().replaceAllMapped(reg, mathFunc) +
                          " ຄົນ",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ToDay",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      todayCount.toString().replaceAllMapped(reg, mathFunc) +
                          " ຄົນ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
