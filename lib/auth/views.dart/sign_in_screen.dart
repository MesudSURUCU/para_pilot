import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:para_pilot/auth/views.dart/sign_up_screen.dart';
import 'package:para_pilot/bottom_navigation_bar.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  late FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController tfEmail = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


 // Mail ve şifre ile kullanıcı girişi için kullanılan metod
  void loginUserEmailandPassword() async {
    try {
      var userCrediantal = await auth.signInWithEmailAndPassword(
          email: tfEmail.text, password: tfPassword.text);
      debugPrint(userCrediantal.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationBarPage()));
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Giriş Hatalı")));
    }
  }

  void logInGoogle() async {
    // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);
   if(!mounted) return;
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigationBarPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash_screen.png"),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "PARA PİLOT",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (tfGirdisi) {
                      if (tfGirdisi == null || tfGirdisi.isEmpty) {
                        return "Bu alan boş bırakılamaz";
                      }
                      return null;
                    },
                    controller: tfEmail,
                    decoration: const InputDecoration(
                        fillColor: Colors.black,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: "Email Adresi",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                      controller: tfPassword,
                      decoration: const InputDecoration(
                          fillColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          labelText: "Şifre",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      bool controlResult = _formKey.currentState!.validate();
                      if (controlResult) {
                        String un = tfEmail.text;
                        String ps = tfPassword.text;
                        debugPrint("Kullanıcı adı : $un - Şifre : $ps");
                      }
                     loginUserEmailandPassword();
                     
                    },
                    child: const Text("Giriş Yap")),
                const SizedBox(height: 100),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(350, 45)),
                  onPressed: () {
                    logInGoogle();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.red,
                      ),
                      Text(
                        "Gmail ile giriş yap",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 45)),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.indigo,
                        ),
                        Text(
                          "Facebook ile giriş yap",
                          style: TextStyle(color: Colors.indigo, fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.indigo,
                        )
                      ],
                    ),
                    ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Hesabınız Yok Mu ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
