import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoading extends StatelessWidget {

  final bool inputTextLoading;

  CountryLoading({@required this.inputTextLoading}) ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       inputTextLoading ? loadingInputCard():Container(),
       loadingCard(),
       loadingCard(),
       loadingChartCard(),
      ],
    );
  }
  Widget loadingInputCard(){
    return Card(
      elevation:1,
      child:Container(
        height:105,
        padding:EdgeInsets.all(24),
        child:Shimmer.fromColors(child: Container(
          width:double.infinity,
          height:57,
          color:Colors.white,
        ), baseColor: Colors.grey[300], highlightColor: Colors.grey[100])
      )
    );
  }
  Widget loadingCard(){
    return Card(
      elevation: 1,
      child: Container(
        height:100,
        padding:EdgeInsets.symmetric(horizontal:16,vertical:8),
        child:Shimmer.fromColors(child:Column(
          children:[
            Container(
              height:20,
              width:100,
              color:Colors.white,
            ),
            Expanded(child: Container()),
            Container(
              width:double.infinity,
              height:15,
              color:Colors.white,
            ),
            SizedBox(height:5),
            Container(
              width:double.infinity,
              height:30,
              color:Colors.white,

            )
          ]
        ) , baseColor: Colors.grey[300], highlightColor: Colors.grey[100])
      ),
    );
  }
  Widget loadingChartCard(){
    return Card(elevation: 1,
    child: Container(
      height:180,
      padding:EdgeInsets.symmetric(horizontal:16,vertical:8),
      child:Shimmer.fromColors(child: Expanded(child: Container(color:Colors.white),), baseColor: Colors.grey[300],
       highlightColor: Colors.grey[100])
    ));
  }
}