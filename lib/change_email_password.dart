import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeMailPasswordPage extends StatefulWidget {
  const ChangeMailPasswordPage({super.key});

  @override
  State<ChangeMailPasswordPage> createState() => _ChangeMailPasswordPageState();
}

class _ChangeMailPasswordPageState extends State<ChangeMailPasswordPage> {

 TextEditingController tfChangeEmail = TextEditingController();
 TextEditingController tfchangePassword = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 late FirebaseAuth auth = FirebaseAuth.instance;

 // Kullanıcı şifre değiştirme için kullanılan metod
  void changePassword() async {
    try {
      await auth.currentUser!.updatePassword("passwordChange");
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        debugPrint("Tekrar oturum açma gerekiyor");
        var credential = EmailAuthProvider.credential(
            email: tfChangeEmail.text, password: tfchangePassword.text);
        await auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.updatePassword("passwordChange");
        await auth.signOut();
        debugPrint("Şifre güncellendi");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  // Kullanıcı mail adresi değiştirme için kullanılan metod
  void changeEmail() async {
     try {
      await auth.currentUser!.verifyBeforeUpdateEmail("emailChange");
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        debugPrint("Tekrar oturum açma gerekiyor");
        var credential = EmailAuthProvider.credential(
            email: tfChangeEmail.text, password: tfchangePassword.text);
        await auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.verifyBeforeUpdateEmail("emailChange");
        await auth.signOut();
        debugPrint("Email güncellendi");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (tfGirdisi) {
                      if (tfGirdisi == null || tfGirdisi.isEmpty) {
                        return "Bu alan boş bırakılamaz";
                      }
                      return null;
                    },
                  controller: tfChangeEmail,
                   decoration: const InputDecoration(
                        fillColor: Colors.black,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: "Güncel E Mail Adresi",
                        labelStyle: TextStyle(
                            color: Colors.black,
                           // fontWeight: FontWeight.bold,
                            fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        )),
                ),
              ),           
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (tfGirdisi) {
                        if (tfGirdisi!.isEmpty) {
                          return "Şifre Giriniz";
                        }
                        if (tfGirdisi.length < 6) {
                          return "Şifreniz en az 6 haneli olmalıdır";
                        }
                        return null;
                      },
                      obscureText: true,
                  controller: tfchangePassword,
                   decoration: const InputDecoration(
                          fillColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          labelText: "Güncel Şifre",
                          labelStyle: TextStyle(
                              color: Colors.black,
                             // fontWeight: FontWeight.bold,
                              fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ))
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  changeEmail();
                  changePassword();
                },
                child: const Text("Güncelle"))
            ],
          ),
        ),
      ),
    );
  }
}