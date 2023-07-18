import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/facebooklogin.dart';
import 'package:water_tracker/pages/info.dart';
import 'package:water_tracker/pages/signup.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  bool pass_visi = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  // bool _isLoggedIn=false;
  // Map _userObj={};
  String token = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.blue, // status bar color
    ));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/sign_bg.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 280,
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    'Singin',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.blue,
                        fontFamily: "Open_sans"),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: TextField(
                                        controller: _email,
                                        decoration: const InputDecoration(
                                            hintText: "Email or Phone No",
                                            border: InputBorder.none),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: TextField(
                                      controller: _password,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pass_visi = false;
                                            });
                                          },
                                          child: Icon(pass_visi
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        hintText: "Password",
                                        border: InputBorder.none,
                                      ),
                                      obscureText: pass_visi,
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: const InkWell(
                                  child: Text(
                                    "Forgot password ?",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 140, 255),
                                        fontSize: 14,
                                        fontFamily: "Open_sans"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                onTap: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  token =
                                      pref.getString('device_token') as String;
                                  var response = await http.post(
                                      Uri.parse(
                                          'https://ennaya.co/dev/appMDDAPI/source=Mobapp_API?action=EMPLOGIN'),
                                      body: {
                                        'u_username': _email.text,
                                        'u_password': _password.text,
                                        'u_device_token': '',
                                        'type': ''
                                      });
                                  var jsonObject = json.decode(response.body);
                                  if (response.statusCode == 200) {
                                    if (jsonObject['Status'] == '1') {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          });
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => info()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "You Enter Wrong Email And Password")));
                                    }
                                  } else {}
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Open_sans"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                            const Flexible(
                                child: Text(
                              'OR',
                              style: TextStyle(fontFamily: "Open_sans"),
                            )),
                            Flexible(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Sign in with",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "Open_sans"),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                signInFacebook();
                                // FacebookAuth.instance.login(permissions: [
                                //   "public_profile",
                                //   'email'
                                // ]).then((value) {
                                //   FacebookAuth.instance.getUserData().then((userData){
                                //     setState(() {
                                //       _isLoggedIn=true;
                                //       _userObj=userData;
                                //     });
                                //   });
                                // });
                              },
                              child: CircleAvatar(
                                radius: 20,
                                child: Image.asset(
                                  'assets/Fb_icon.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                GoogleSignInAccount? googleuser =
                                    await GoogleSignIn().signIn();
                                GoogleSignInAuthentication? googleauth =
                                    await googleuser?.authentication;

                                AuthCredential credential =
                                    GoogleAuthProvider.credential(
                                  accessToken: googleauth?.accessToken,
                                  idToken: googleauth?.idToken,
                                );

                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);

                                if (userCredential != null) {
                                  print(userCredential.user?.displayName);
                                  print(userCredential.user?.email);
                                  print(userCredential.user?.uid);
                                  print(userCredential.user?.getIdToken());

                                  // jsonD = jsonDecode()
                                  Send_SocialLogin_Data(
                                      userCredential.user!.displayName
                                          as String,
                                      userCredential.user!.email as String,
                                      userCredential.user?.uid as String);
                                } else {
                                  print('invalid cread');
                                }

                                // signinwithgoogle();
                              },
                              child: CircleAvatar(
                                radius: 22,
                                child: Image.asset(
                                  'assets/Gmail_icon.png',
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Open_sans"),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const signup()));
                                },
                                child: const Text(
                                  " Sign up",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(
                                        255,
                                        0,
                                        140,
                                        255,
                                      ),
                                      fontFamily: "Open_sans"),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void Send_SocialLogin_Data(String name, String email, String id) async {
    var response = await http.post(
        Uri.parse(
            'https://ennaya.co/dev/appMDDAPI/source=Mobapp_API?action=SOCIALLOGIN'),
        body: {
          'u_name': name,
          'u_email': email,
          'u_mobile': '',
          'u_device_token': '',
          'u_join_source': 'Google',
          'u_social_id': id
        });
    var jsonObject = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonObject['Status'] == '1') {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => info()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter Valid Google Account")));
      }
    } else {}
  }
}
