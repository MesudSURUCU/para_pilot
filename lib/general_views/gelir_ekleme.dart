import 'package:flutter/material.dart';
import 'package:para_pilot/bottom_navigation_bar.dart';

class GelirEkleme extends StatefulWidget {
  const GelirEkleme({super.key});

  @override
  State<GelirEkleme> createState() => _GelirEklemeState();
}

class _GelirEklemeState extends State<GelirEkleme> {

TextEditingController tfGelirEkle = TextEditingController();
TextEditingController tfKategoriEkle = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Gelir Ekleme Sayfası"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: tfGelirEkle,
                decoration: const InputDecoration(
                  labelText: "Tutar Giriniz"
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                  controller: tfKategoriEkle,
                  decoration: const InputDecoration(
                    labelText: "Kategori Giriniz"
                  ),
                ),
             ),
            ElevatedButton(
             
                onPressed: () {
                  var addDataMap = {
                                tfKategoriEkle.text : double.parse(tfGelirEkle.text)
                              };
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            
                            return  BottomNavigationBarPage(addDataMap: addDataMap,);
                          }));
                },
                child: const Text("Ekle"))
          ],
        ),
      ),
    );
  }
}
