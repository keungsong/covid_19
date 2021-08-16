import 'package:covid_19/models/country.dart';
import 'package:covid_19/models/country_summary.dart';
import 'package:covid_19/screens/country_statistics.dart';
import 'package:covid_19/services/covid_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

CovidServices covidServices = CovidServices();

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final TextEditingController _textEditingController = TextEditingController();
  Future<List<CountryModel>> countryList;
  Future<List<CountrySummaryModel>> summaryList;

  @override
  void initState() {
    super.initState();
    countryList = covidServices.getCountryList();
    summaryList = covidServices.getCountrySummary("lao-pdr");
    this._textEditingController.text = "Lao PDR";
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = List();

    for (var item in list) {
      matches.add(item.country);
    }
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: countryList,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text("Error"),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text("Loading..."),
              );
            default:
              return !snapshot.hasData
                  ? Center(
                      child: Text("Empty"),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: Text(
                            "ຄົ້ນຫາຊື່ປະເທດ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                  hintText: "ປ້ອນຊື່ປະເທດ",
                                  hintStyle: TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.all(20),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 24, right: 16),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  ))),
                          suggestionsCallback: (pattern) {
                            return _getSuggestions(snapshot.data, pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            this._textEditingController.text = suggestion;
                            setState(() {
                              summaryList = covidServices.getCountrySummary(
                                  snapshot
                                      .data
                                      .firstWhere((element) =>
                                          element.country == suggestion)
                                      .sulg);
                            });
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FutureBuilder(
                            future: summaryList,
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Center(
                                  child: Text("Error"),
                                );
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Text("Loading..."),
                                  );
                                default:
                                  return !snapshot.hasData
                                      ? Center(
                                          child: Text("Empty"),
                                        )
                                      : CountryStatistics(
                                          summaryList: snapshot.data);
                              }
                            })
                      ],
                    );
          }
        });
  }
}
