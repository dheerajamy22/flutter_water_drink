import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_tracker/pages/bmi.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
           Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            height: 120,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 InkWell(
                   child:const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                                 ),
                                 onTap: (){
                                  Navigator.pop(context);
                                 },
                 ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                 
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>body_mass_index()));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color:  Color.fromARGB(255, 241, 241, 241),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 20,),
                                   SvgPicture.asset("assets/bmiicon.svg"),
                                   SizedBox(width: 40,),
                                Text("BMI Calculator"),
                                ],
                               ),
                                Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                              ],
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                 SvgPicture.asset("assets/steps.svg",height: 30,),
                                 SizedBox(width: 40,),
                              Text("Step Counter"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                 Icon(Icons.notifications,color: Colors.blue,),
                                 SizedBox(width: 40,),
                              Text("Reminder"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.history,color: Colors.blue,) ,
                                 SizedBox(width: 40,),
                              Text("History"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                SvgPicture.asset("assets/cleandata.svg",height: 20,),
                                 SizedBox(width: 40,),
                              Text("Cleaning Data"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.volume_up,color: Colors.blue,) ,
                                 SizedBox(width: 40,),
                              Text("Sound"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.privacy_tip_outlined,color: Colors.blue,) ,
                                 SizedBox(width: 40,),
                              Text("Privacy and Policy"),
                              ],
                             ),
                              Icon(Icons.arrow_forward_ios,color: Colors.blue,),                         
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
          )
        ],
      ),
    );
  }
}