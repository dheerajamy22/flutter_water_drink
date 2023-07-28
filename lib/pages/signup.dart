import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_tracker/pages/facebooklogin.dart';
import 'package:water_tracker/pages/info.dart';
import 'package:water_tracker/pages/signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool pass_visi=true;
  bool confirm_pass=true;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/sign_bg.png", fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 90),
                      child: const Text(
                        "Create an Account",
                        style: TextStyle(
                            fontSize: 30,
                            color: const Color.fromARGB(255, 19, 137, 233),
                            fontFamily: "Open_sans"),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 48,
                      child: TextField(
                        controller: _name,
                        decoration: const InputDecoration(
                            hintText: "Enter Full Name",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child: TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                            hintText: "Email or Phone No",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child: TextField(
                        controller: _gender,
                        decoration: const InputDecoration(
                            hintText: "Gender", border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child: TextField(
                        controller: _password,
                        decoration:  InputDecoration(
                           suffixIcon: GestureDetector(onTap: (){
                                            setState(() {
                                              pass_visi=false;
                                            });
                                          },
                                          child: Icon(pass_visi?Icons.visibility_off:Icons.visibility),
                                          ),
                            hintText: "Password", border: OutlineInputBorder()),
                            obscureText: pass_visi,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child:  TextField(
                        decoration: InputDecoration(
                           suffixIcon: GestureDetector(onTap: (){
                                            setState(() {
                                              confirm_pass=false;
                                            });
                                          },
                                          child: Icon(confirm_pass?Icons.visibility_off:Icons.visibility),
                                          ),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder()),
                            obscureText: confirm_pass,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            });
                        print(_name.text +
                            _email.text +
                            _gender.text +
                            _password.text);
                        var response = await http.post(
                            Uri.parse(
                                'https://ennaya.co/dev/appMDDAPI/source=Mobapp_API?action=REGISTER'),
                            body: {
                              'u_fname': _name.text,
                              'u_email': _email.text,
                              'u_mobile': '',
                              'u_gender': _gender.text,
                              'u_device_token': '',
                              'u_password': _password.text,
                              'u_join_source': 'APP'
                            });
                        var jsonObject = json.decode(response.body);
                        if (response.statusCode == 200) {
                          if (jsonObject['Status'] == '1') {
                            print('if ' + response.body);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Your Account Is Created")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signin()));
                          } else {
                            print('else ' + response.body);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            // const SnackBar(
                            //     content: Text('jsonObject['Message'].toString()')));
                          }
                        } else {
                          print('status ' + response.body);
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Open_sans"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 15.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(fontFamily: "Open_sans"),
                        ),
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15.0, right: 10.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Sign in with",
                      style: TextStyle(fontSize: 16, fontFamily: "Open_sans"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                             signInFacebook();
                          },
                          child: CircleAvatar(
                            radius: 24,
                            child: Image.asset(
                              'assets/Fb_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap:()async {
                            //mDSgENUh54dOZxv6H60Yw4bUYTu1
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
                                        userCredential.user?.uid as String
                                        );
                                  } else {
                                    print('invalid cread');
                                  }
                          },
                          child: CircleAvatar(
                            radius: 27,
                            child: Image.asset(
                              'assets/Gmail_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16, fontFamily: "Open_sans"),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signin()));
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(255, 0, 140, 255),
                                  fontFamily: "Open_sans"),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void Send_SocialLogin_Data(String name, String email, String id)async {
     var response = await http.post(
                                      Uri.parse(
                                          'https://ennaya.co/dev/appMDDAPI/source=Mobapp_API?action=SOCIALLOGIN'),
                                      body: {
                                        'u_name': name,
                                        'u_email': email,
                                        'u_mobile': '',
                                        'u_device_token': '',
                                        'u_join_source': 'Google',
                                        'u_social_id':id
                                      });
                                  var jsonObject = json.decode(response.body);
                                  if (response.statusCode == 200) {
                                    if (jsonObject['Status'] == '1') {
                                      
                                     
                                      
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>info()));
                                               showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please Enter Valid Google Account")));
                                    }
                                  } else {}
  }
}
