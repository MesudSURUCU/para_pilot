import 'dart:math';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:para_pilot/general_views/gelir_ekleme.dart';
import 'package:para_pilot/general_views/gelir_sayfa.dart';
import 'package:para_pilot/general_views/genel_sayfa.dart';
import 'package:para_pilot/general_views/gider_ekleme.dart';
import 'package:para_pilot/general_views/gider_sayfa.dart';
import 'package:para_pilot/general_views/profil_sayfa.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage(
      {super.key, this.addDataMap, this.removeDataMap});

  final Map<String, double>? addDataMap;
  final Map<String, double>? removeDataMap;

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with TickerProviderStateMixin {
  late AnimationController animationControl;

  late Animation<double> scaleAnimationValue;
  late Animation<double> rotateAnimationValue;

  bool fabDurum = false;

  int _currentPage = 0;
  final _pageController = PageController();

  var screenList = [
    const GenelSayfa(),
    const GelirSayfa(),
    const GiderSayfa(),
    const ProfilSayfa(),
  ];

  @override
  void initState() {
    super.initState();

    animationControl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    scaleAnimationValue = Tween(begin: 0.0, end: 1.0).animate(animationControl)
      ..addListener(() {
        setState(() {});
      });

    rotateAnimationValue =
        Tween(begin: 0.0, end: pi / 4).animate(animationControl)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    animationControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            const GenelSayfa(),
            GelirSayfa(
              addDataMap: widget.addDataMap,
            ),
            GiderSayfa(
              removeDataMap: widget.removeDataMap,
            ),
            const ProfilSayfa(),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BottomBar(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                title: const Text("Ana Sayfa"),
                activeColor: Colors.blue,
                inactiveColor: Colors.blue.shade600),
            BottomBarItem(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                title: const Text("Gelirler"),
                activeColor: Colors.greenAccent,
                inactiveColor: Colors.greenAccent.shade700),
            BottomBarItem(
                icon: const Icon(
                  Icons.remove,
                  size: 30,
                ),
                title: const Text("Giderler"),
                activeColor: Colors.red,
                inactiveColor: Colors.red.shade600),
            BottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text("Profil"),
                activeColor: Colors.orange.shade600,
                inactiveColor: Colors.orange.shade700),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: scaleAnimationValue.value,
              child: SizedBox(
                height: 50,
                width: 100,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GelirEkleme()));
                  },
                  tooltip: "Gelir Ekle",
                  backgroundColor: Colors.yellow,
                  child: const Text("Gelir Ekle"),
                ),
              ),
            ),
            Transform.scale(
              scale: scaleAnimationValue.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GiderEkleme()));
                    },
                    tooltip: "Gider Ekle",
                    backgroundColor: Colors.orange,
                    child: const Text("Gider Ekle"),
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: rotateAnimationValue.value,
              child: FloatingActionButton(
                heroTag: "btn3",
                onPressed: () {
                  debugPrint("Fab Main tıklandı");
                  if (fabDurum) {
                    animationControl.reverse();
                    fabDurum = false;
                  } else {
                    animationControl.forward();
                    fabDurum = true;
                  }
                },
                tooltip: "Fab Main",
                backgroundColor: const Color.fromARGB(255, 70, 64, 251),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
