import 'dart:convert';

import 'package:covid_19/models/country.dart';
import 'package:covid_19/models/country_summary.dart';
import 'package:http/http.dart' as http;

import '../global_summary.dart';

class CovidServices {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    final data = await http.Client()
        .get(Uri.parse("https://api.covid19api.com/summary"));

    if (data.statusCode != 200) throw Exception();

    GlobalSummaryModel summary =
        new GlobalSummaryModel.fromJson(json.decode(data.body));

    return summary;
  }

  Future<List<CountrySummaryModel>> getCountrySummary(String slug) async {
    final data = await http.Client().get(
        Uri.parse("https://api.covid19api.com/total/dayone/country/" + slug));

    if (data.statusCode != 200) throw Exception();

    List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
        .map((item) => new CountrySummaryModel.fromJson(item))
        .toList();

    return summaryList;
  }

  Future<List<CountryModel>> getCountryList() async {
    final data = await http.Client()
        .get(Uri.parse("https://api.covid19api.com/countries"));

    if (data.statusCode != 200) throw Exception();

    List<CountryModel> countries = (json.decode(data.body) as List)
        .map((item) => new CountryModel.fromJson(item))
        .toList();

    return countries;
  }
}
