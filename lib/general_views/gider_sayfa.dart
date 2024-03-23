import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GiderSayfa extends StatefulWidget {
  const GiderSayfa({super.key, this.removeDataMap});
final Map<String, double>? removeDataMap;
  @override
  State<GiderSayfa> createState() => _GiderSayfaState();
}

class _GiderSayfaState extends State<GiderSayfa> {

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  Text("Gider Sayfası"),
           (widget.removeDataMap == null) ? const PieChart(dataMap: {'Giderlerinizi Ekleyiniz' : 100.0}) : PieChart(dataMap: widget.removeDataMap!)
          ],
        ),
      ),
    );
  }
}
