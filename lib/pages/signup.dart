import 'package:flutter/material.dart';
import 'package:water_tracker/pages/signin.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: const Color.fromARGB(255, 19, 137, 233)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(height: 48,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Enter Full Name",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(height: 48,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Email or Phone No",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(height: 48,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Gender", border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(height: 48,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Password", border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(height: 48,   
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signin()));
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                      const Text("OR"),
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
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
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
                    height: 20,
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
                                    builder: (context) => signin()));
                          },
                          child:const Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 140, 255)),
                          ))
                    ],
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
