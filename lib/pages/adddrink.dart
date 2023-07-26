import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/custom_drink/fav_data.dart';
import 'package:water_tracker/pages/mainscreen.dart';

import 'custom_drink/custom_drink_class.dart';

class adddrink extends StatefulWidget {
  final String rem_value;
  const adddrink({super.key, required this.rem_value});

  @override
  State<adddrink> createState() => _adddrinkState();
}

class _adddrinkState extends State<adddrink> {
  double _slidervalue = 25;
  String water_value = '25';
  String oz_value = '0.8';
  String? target = '';
  String? oz = '';
  String oz_remain = '0';
  String water_data = "200";

  List<custom_drink> custom_array = [];
  List<FavData> fav_data_array = [];

  void getValue() async {
    SharedPreferences pr = await SharedPreferences.getInstance();

    setState(() {
      target = pr.getString('target');
      oz = pr.getString('oz');
    });
  }

  void load_DrinkStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> favData = pref.getStringList('fav_data') ?? [];

    if (!favData.isEmpty) {
      fav_data_array = favData
          .map((jsonString) => FavData.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      custom_array.add(custom_drink(
          img: 'assets/water.svg',
          name: 'Water',
          Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/coconutwater.svg',
          name: 'Coconut water',
          Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/colddrink.svg',
          name: 'Cold drink',
          Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/cocktail.svg',
          name: 'Cocktail',
          Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/energydrink.svg',
          name: 'Energy drink',
          Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/milk.svg',
          name: 'Milk',
          Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/mocktail.svg',
          name: 'Mocktail',
          Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/proteinshake.svg',
          name: 'Protein shake',
          Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/soup.svg',
          name: 'Soup',
          Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/tea.svg', name: 'Tea', Status: '0'));
    }
  }

  @override
  void initState() {
    getValue();
    load_DrinkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            height: 120,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
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
                  "Add Drink",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Open_sans"),
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
            child: Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 2,
                    mainAxisExtent: 160),
                    shrinkWrap: true,
                    itemCount: custom_array.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    addDrinkDilog();
                                  },
                                  child: Container(
                                    height: 140,
                                  
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 168, 211, 247)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(custom_array[index].img,height: 45,),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                         Text(
                                          custom_array[index].name,
                                          style: TextStyle(
                                              fontFamily: "Open_sans"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                               if(custom_array[index].Status=='1')...[
                                 Container(
                                 alignment: Alignment.topRight,
                                 margin: EdgeInsets.only(top: 10,right: 10),
                                  child:
                                      SvgPicture.asset("assets/filledlike.svg"),
                                ),
                               ]else...[
                                Container(
                                 alignment: Alignment.topRight,
                                 margin: EdgeInsets.only(top: 10,right: 10),
                                  child:
                                      SvgPicture.asset("assets/unlike.svg"),
                                ),
                               ]
                              ],
                            ),
                            
                          ],
                        ),
                      );
                    })),
          )
        ],
      )),
    );
  }

  void addDrinkDilog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
                height: 250,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.blue,
                          )),
                    ),
                    const Text("How Much Did You Drink Last?",
                        style: TextStyle(fontFamily: "Open_sans")),
                    StatefulBuilder(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(water_value + " ml",
                                    style: TextStyle(fontFamily: "Open_sans")),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(oz_value + " oz",
                                    style: TextStyle(fontFamily: "Open_sans")),
                              ],
                            ),
                            Slider(
                              value: _slidervalue,
                              label: _slidervalue.round().toString(),
                              onChanged: ((double value) {
                                state(() {});
                                setState(() {
                                  _slidervalue = value;

                                  String water_value1 = _slidervalue.toString();
                                  String str = water_value1;
                                  var arr = str.split('.');
                                  water_value = arr[0];

                                  double oz =
                                      (double.parse(water_value) * 0.038);
                                  oz_value = oz.toStringAsFixed(0);

                                  print('object');
                                });
                              }),
                              max: 600,
                              divisions: 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      state(
                                        () {
                                          _slidervalue--;

                                          water_value = _slidervalue.toString();
                                          String str = water_value;
                                          var arr = str.split('.');
                                          water_value = arr[0];
                                          double oz =
                                              (double.parse(water_value) *
                                                  0.038);
                                          oz_value = oz.toStringAsFixed(0);
                                        },
                                      );
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Colors.blue)),
                                const SizedBox(
                                  width: 100,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      state(
                                        () {
                                          _slidervalue += 1;
                                          water_value = _slidervalue.toString();
                                          String str = water_value;
                                          var arr = str.split('.');
                                          water_value = arr[0];
                                          double oz =
                                              (double.parse(water_value) *
                                                  0.038);
                                          oz_value = oz.toStringAsFixed(0);
                                        },
                                      );
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    )),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    StatefulBuilder(builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () async {
                              int a = int.parse(widget.rem_value.toString()) -
                                  int.parse(water_value);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => mainscreen(
                                        access_from: 'add_drink',
                                        cat_water_value: a.toString(),
                                      )));
                            },
                            child: const Text("UNDO",
                                style: TextStyle(fontFamily: "Open_sans")),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          TextButton(
                            onPressed: () {
                              int a = int.parse(widget.rem_value.toString()) +
                                  int.parse(water_value);
                              AssetsAudioPlayer.newPlayer().open(
                                Audio("assets/audio/water_drop.mp3"),
                                autoStart: true,
                                showNotification: false,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => mainscreen(
                                        access_from: 'add_drink',
                                        cat_water_value: a.toString(),
                                      )));
                            },
                            child: const Text("ADD",
                                style: TextStyle(fontFamily: "Open_sans")),
                          ),
                        ],
                      );
                    })
                  ],
                )),
          );
        });
  }
}
