import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_tracker/pages/setting.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return SafeArea(
        child: Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          height: 120,
          decoration: const BoxDecoration(color: Colors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                    InkWell(
                  onTap: () {
                    Navigator.of(context).pop("context");
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Profile",
                style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Open_sans"),
              ),
                ],
              ),
            
              IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => setting()));
                    },
                    icon: Icon(Icons.settings,weight: 25),
                    color: Colors.white,
                  )
            ],
          ),
        ),
             
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 48,
                            margin: EdgeInsets.only(top: 56),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "Name"),
                                readOnly: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(5),
                            //   border: Border.all(color: Colors.blue),
                            // ),
                            child: const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Email"),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            child: const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Gender"),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            child: const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  // labelText: "Date of Birth",
                                  hintText: "DD-MM-YYYY",
                                  suffixIcon: Icon(Icons.calendar_month)),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            child: Row(
                              children: [
                                const Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "weight",
                                    ),
                                    readOnly: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SvgPicture.asset("assets/kg.svg")
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: const Flexible(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Height",
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SvgPicture.asset("assets/cm.svg")
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80),
              height: 50,
              child: CircleAvatar(
                radius: 25,
                child: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
