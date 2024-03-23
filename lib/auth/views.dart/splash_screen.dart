import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:para_pilot/auth/views.dart/sign_in_screen.dart';
import 'package:para_pilot/bottom_navigation_bar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    late FirebaseAuth auth = FirebaseAuth.instance;
  
  void sessionControl() async{

   auth.authStateChanges().listen((User? user) {
     if (user == null) {
        debugPrint("User oturumu kapalı");
        if(!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));

      } else {
        debugPrint(
            "User oturum açık ${user.email} ve email durumu ${user.emailVerified}");
            if(!mounted) return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigationBarPage()));
            
      }
    });

   }
 
  @override
  void initState() {
    super.initState();
   sessionControl();
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_screen.png"),
            fit: BoxFit.cover)),)
    );
  }
}