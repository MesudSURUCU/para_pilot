import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GelirSayfa extends StatefulWidget {
  const GelirSayfa({super.key, this.addDataMap});

  final Map<String, double>? addDataMap;

  @override
  State<GelirSayfa> createState() => _GelirSayfaState();
}

class _GelirSayfaState extends State<GelirSayfa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Gelir Sayfası"), 
             (widget.addDataMap == null) ? const PieChart(dataMap: {'Gelirlerinizi Ekleyiniz' : 100.0}) : PieChart(dataMap: widget.addDataMap!)
            ],
        ),
      ),
    );
  }
}
