import 'package:covid_19/screens/global_loading.dart';
import 'package:covid_19/screens/global_statistics.dart';
import 'package:covid_19/services/covid_services.dart';
import 'package:flutter/material.dart';

import '../global_summary.dart';

CovidServices covidServices = CovidServices();

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Future<GlobalSummaryModel> summary;

  @override
  void initState() {
    super.initState();
    summary = covidServices.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ກໍລະນີຕິດເຊື້ອໄວຣັດ covid-19 ທົ່ວໂລກ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    summary = covidServices.getGlobalSummary();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        FutureBuilder(
            future: summary,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Error"),
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return GlobalLoading();
                default:
                  return !snapshot.hasData
                      ? Center(
                          child: Text("Empty"),
                        )
                      : GlobalStatistics(summary: snapshot.data);
              }
            })
      ],
    );
  }
}
