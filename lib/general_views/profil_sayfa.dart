import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:para_pilot/auth/views.dart/sign_in_screen.dart';
import 'package:para_pilot/change_email_password.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({super.key});

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {

  FirebaseAuth auth = FirebaseAuth.instance;
 

  // Kullanıcı çıkışı için kullanılan metod
  void signOutUser() async {
    var user =  GoogleSignIn().currentUser;
    if(user != null) {
      await GoogleSignIn().signOut();}
    await auth.signOut();
    if(!mounted) return;
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
  }

  // Kullanıcı silmek için kullanılan metod  
  void deleteUser() async {
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
      if(!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
    } else {
      debugPrint("Kullanıcı oturum açmadığı için silinemez");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              signOutUser();
             
            }, child: const Text("Çıkış Yap")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {
              deleteUser();
            }, child: const Text("Hesabı Sil")),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeMailPasswordPage()));
              },
              child: const Text("Mail/Şifre Değiştir"))
          ],
        ),
      ),
    );
  }
}
