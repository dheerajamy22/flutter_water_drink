import 'package:flutter/material.dart';



class body_mass_index extends StatefulWidget {
  const body_mass_index({super.key});

  @override
  State<body_mass_index> createState() => _body_mass_indexState();
}

class _body_mass_indexState extends State<body_mass_index> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
           Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            height: 70,
            decoration: const BoxDecoration(color: Colors.blue),
            child:const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                 SizedBox(
                  width: 20,
                ),
                 Text(
                  "BMI Calculator",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                 
              ],
            ),
          ),
          Container(
             width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 70),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text("Age",style: TextStyle(color: Colors.blue),),
                        Text("height",style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ],
                ),
          )
        ],
      ),
    ));
  }
}