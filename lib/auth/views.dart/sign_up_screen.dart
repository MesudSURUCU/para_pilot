import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:para_pilot/auth/views.dart/sign_in_screen.dart';
import 'package:para_pilot/bottom_navigation_bar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  late FirebaseAuth auth = FirebaseAuth.instance;
  
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfEmail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// Kullanıcı kayıt etmek için kullanılan metod
void createUserEmailandPassword() async {
  // Kayıt olunan yere SignUp kısmına yapılacak
  try {
    var userCrediantal = await auth.createUserWithEmailAndPassword(
        email: tfEmail.text, password: tfPassword.text);
    debugPrint(userCrediantal.toString());
    var myUser = userCrediantal.user; // O an oturum açmış kullanıcı
    if (!myUser!.emailVerified) {
      await myUser.sendEmailVerification();
    } else {
      debugPrint("Kullanıcının maili onaylanmış, ilgili sayfaya gidebilir. ");
    }
  } catch (e) {
    debugPrint(e.toString());
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
                    controller: tfEmail,
                       decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Ad Soyad",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(40))
                      )                     
                    ),
                  ),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (tfGirdisi) {
                      if(tfGirdisi == null || tfGirdisi.isEmpty){
                        return "Bu alan boş bırakılamaz";
                      }
                      return null;
                    },
                    controller: tfEmail,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Email Adresi",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(40))
                      )                     
                    ),
                  ),
                ),
                TextFormField(
                   validator: (tfGirdisi) {
                    if(tfGirdisi!.isEmpty){
                      return "Şifre Giriniz";
                    }
                    if (tfGirdisi.length <6) {
                      return "Şifreniz en az 6 haneli olmalıdır";
                    }
                    return null;
                  },
                  controller: tfPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius.circular(40))
                    )
                   
                  ),
                ),
                ElevatedButton(onPressed: (){
                 createUserEmailandPassword();
                },
                 child: const Text("Kayıt Ol")),
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
                        "Gmail ile kayıt ol",
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
                          "Facebook ile kayıt ol",
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
                        "Hesabınız Var Mı?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SigninPage()));
                          },
                          child: const Text(
                            "Giriş Yap",
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