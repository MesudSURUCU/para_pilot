import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GenelSayfa extends StatefulWidget {
  const GenelSayfa({
    super.key,
  });

  @override
  State<GenelSayfa> createState() => _GenelSayfaState();
}

class _GenelSayfaState extends State<GenelSayfa> {


  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Genel Sayfa"),
              ),
              PieChart(
                dataMap: {"asd": 50, "Yeşil": 25, "Mavi": 20, "örn": 5},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
