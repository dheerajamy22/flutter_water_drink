 import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:water_tracker/pages/onbaord2.dart';
import 'package:water_tracker/pages/onboard1.dart';
import 'package:water_tracker/pages/signin.dart';



class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
PageController _controller=PageController();
bool onlastpage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
           
            child: Image.asset('assets/bg.png',fit: BoxFit.fill,),
          ),
          Container(
   
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index){
                    setState(() {
                      onlastpage=(index==1);
                    });
                  },
                  children:  [
                      Container(
                        height: 200,
                        child: onboard1()),
                      Container(
                        height: 200,
                        child: onboard2()),
                  ],
                ),
                Container(
                  alignment: Alignment(0, 0.75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>signin()));
                        },
                        child: const Text("Skip",
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Open_sans"
                        ),
                        ),
                        ),
                      SmoothPageIndicator(controller: _controller,count: 2,),
                     onlastpage? GestureDetector(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>signin()));
                        },
                        child:const Text("Done",
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Open_sans"
                        ),
                        ),

                        )
                        :GestureDetector(
                        onTap: (){
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500), 
                          curve:Curves.easeIn);
                        },
                        child:const Text("Next",
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Open_sans"
                        ),
                        ),
                        ),
                    ],
                  ),
                  )
              ],
            )
          )
        
        ],
      ),
    );
  }
}