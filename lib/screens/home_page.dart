import 'package:covid_19/screens/country.dart';
import 'package:covid_19/screens/global.dart';
import 'package:covid_19/screens/navigation_option.dart';
import 'package:flutter/material.dart';

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('ຜົນໂຄວິດ-19',style: TextStyle(color: Colors.blue),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: navigationStatus == NavigationStatus.GLOBAL
                  ? Global()
                  : Country(),
            ),
          )),
          Container(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationOption(
                    title: "ທົ່ວໂລກ",
                    selected: navigationStatus == NavigationStatus.GLOBAL,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.GLOBAL;
                      });
                    }),
                NavigationOption(
                    title: "ປະເທດ",
                    selected: navigationStatus == NavigationStatus.COUNTRY,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.COUNTRY;
                      });
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
