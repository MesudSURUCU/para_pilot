import 'package:flutter/material.dart';
import 'package:para_pilot/bottom_navigation_bar.dart';

class GiderEkleme extends StatefulWidget {
  const GiderEkleme({super.key});

  @override
  State<GiderEkleme> createState() => _GiderEklemeState();
}

class _GiderEklemeState extends State<GiderEkleme> {

TextEditingController tfGiderEkle = TextEditingController();
TextEditingController tfKategoriEkle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text("Gider Ekleme Sayfası"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: tfGiderEkle,
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
            ElevatedButton(onPressed: (){
               var removeDataMap = {
                                tfKategoriEkle.text : double.parse(tfGiderEkle.text)
                              };
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage(removeDataMap: removeDataMap,)));
            }, 
            child: const Text("Ekle") )
          ],
        ),
      ),
    );
  }
}