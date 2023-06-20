import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.blue, // status bar color
    ));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/sign_bg.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 280,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    'Singin',
                    style: TextStyle(fontSize: 28, color: Colors.blue),
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
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Email or Phone No",
                                            border: InputBorder.none),
                                      ),
                                    )),
                              ),
                              SizedBox(
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
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: const InkWell(
                                  child: Text(
                                    "Forgot password ?",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 140, 255),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => info()));
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
                                        color: Colors.white, fontSize: 16),
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
                    padding: EdgeInsets.only(bottom: 24),
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
                            Flexible(child: Text('OR')),
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
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Image.asset(
                                'assets/Fb_icon.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            CircleAvatar(
                              radius: 22,
                              child: Image.asset(
                                'assets/Gmail_icon.png',
                                width: 45,
                                height: 45,
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
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signup()));
                                },
                                child: const Text(
                                  " Sign up",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 140, 255)),
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
}
