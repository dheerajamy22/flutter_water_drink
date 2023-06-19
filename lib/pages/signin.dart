import 'package:flutter/material.dart';
import 'package:water_tracker/pages/info.dart';
import 'package:water_tracker/pages/signup.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
               height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/sign_bg.png",fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 19, 137, 233),
                              fontSize: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "Email or Phone No",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: const InkWell(
                          child: Text(
                            "Forgotten Password?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 140, 255)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => info()));
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
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 15.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 50,
                                )),
                          ),
                          const Text("OR"),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 10.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 50,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Sign in with",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            child: Image.asset(
                              'assets/Fb_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          CircleAvatar(
                            radius: 27,
                            child: Image.asset(
                              'assets/Gmail_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signup()));
                              },
                              child:const Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Color.fromARGB(255, 0, 140, 255)),
                              ))
                        ],
                      ),
                      SizedBox(height: 50,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
