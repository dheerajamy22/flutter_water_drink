import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/custom_drink/fav_data.dart';
import 'package:water_tracker/pages/mainscreen.dart';
import 'package:water_tracker/pages/water_bar_charts/water_week_array.dart';

import 'custom_drink/custom_drink_class.dart';

class adddrink extends StatefulWidget {
  final String rem_value;
  adddrink({super.key, required this.rem_value});

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
  // bool _visi_unlike = true, _visi_like = true;

  final DateTime date = DateTime.now();
  String current_date = "";
  String days = '';

  List<WeekWaterBarChartModel> week_array = [];

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
    List<String> favData = pref.getStringList('fevData') ?? [];
    current_date = DateFormat('MM-dd').format(date);
    days = DateFormat('EEE').format(date);

    if (!favData.isEmpty) {
      fav_data_array = favData
          .map((jsonString) => FavData.fromJson(jsonDecode(jsonString)))
          .toList();

      custom_array.add(
          custom_drink(img: 'assets/water.svg', name: 'Water', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/coconutwater.svg', name: 'Coconut water', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/colddrink.svg', name: 'Cold drink', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/cocktail.svg', name: 'Cocktail', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/energydrink.svg', name: 'Energy drink', Status: '0'));
      custom_array
          .add(custom_drink(img: 'assets/milk.svg', name: 'Milk', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/mocktail.svg', name: 'Mocktail', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/proteinshake.svg', name: 'Protein shake', Status: '0'));
      custom_array
          .add(custom_drink(img: 'assets/soup.svg', name: 'Soup', Status: '0'));
      custom_array
          .add(custom_drink(img: 'assets/tea.svg', name: 'Tea', Status: '0'));

      for (int i = 0; i < custom_array.length; i++) {
        for (int j = 0; j < fav_data_array.length; j++) {
          if (fav_data_array[j].name == custom_array[i].name) {
            custom_array.setAll(i, [
              custom_drink(
                  img: fav_data_array[j].img,
                  name: fav_data_array[j].name,
                  Status: fav_data_array[j].Status)
            ]);
          }
        }
      }

      // List<String> jsonList =
      //     custom_array.map((f_data) => jsonEncode(f_data.toJson())).toList();
      // pref.setStringList('fevData', jsonList);
      // pref.commit();
    } else {
      print('else');
      custom_array.add(
          custom_drink(img: 'assets/water.svg', name: 'Water', Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/coconutwater.svg', name: 'Coconut water', Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/colddrink.svg', name: 'Cold drink', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/cocktail.svg', name: 'Cocktail', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/energydrink.svg', name: 'Energy drink', Status: '1'));
      custom_array
          .add(custom_drink(img: 'assets/milk.svg', name: 'Milk', Status: '1'));
      custom_array.add(custom_drink(
          img: 'assets/mocktail.svg', name: 'Mocktail', Status: '0'));
      custom_array.add(custom_drink(
          img: 'assets/proteinshake.svg', name: 'Protein shake', Status: '0'));
      custom_array
          .add(custom_drink(img: 'assets/soup.svg', name: 'Soup', Status: '0'));
      custom_array
          .add(custom_drink(img: 'assets/tea.svg', name: 'Tea', Status: '0'));

      for (int i = 0; i < custom_array.length; i++) {
        if (custom_array[i].Status == '1') {
          fav_data_array.add(FavData(
              img: custom_array[i].img,
              name: custom_array[i].name,
              Status: custom_array[i].Status));
        }
      }

      List<String> jsonList =
          fav_data_array.map((f_data) => jsonEncode(f_data.toJson())).toList();
      pref.setStringList('fevData', jsonList);
      pref.commit();
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
    return WillPopScope(
      onWillPop: () async=>false,
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              height: 120,
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        if(fav_data_array.length<4){
                           ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Please select 4 drinks')));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>mainscreen(access_from: "", cat_water_value: "")));
                        }
                        
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
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
              margin: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
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
                      padding: EdgeInsets.all(8.0),
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
                                      color: Color.fromARGB(255, 168, 211, 247)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        custom_array[index].img,
                                        height: 45,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        custom_array[index].name,
                                        style: TextStyle(fontFamily: "Open_sans"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (custom_array[index].Status == '1') ...[
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                    child:
                                        SvgPicture.asset("assets/filledlike.svg"),
                                  ),
                                  onTap: () async {
                                    SharedPreferences sp =
                                        await SharedPreferences.getInstance();
    
                                    List<String> favData =
                                        sp.getStringList('fevData') ?? [];
    
                                    fav_data_array = favData
                                        .map((jsonString) => FavData.fromJson(
                                            jsonDecode(jsonString)))
                                        .toList();
    
                                    int a = fav_data_array.length;
    
                                    if (a <= 4) {
                                      print('jhfd nbuhr');
                                      String bevName = custom_array[index].name;
    
                                      for (int i = 0;
                                          i < fav_data_array.length;
                                          i++) {
                                        if (bevName == fav_data_array[i].name) {
                                          // fav_data_array.remove(i);
                                          fav_data_array.removeWhere((element) =>
                                              element.name == bevName);
    
                                          for (int j = 0;
                                              j < custom_array.length;
                                              j++) {
                                            if (bevName == custom_array[j].name) {
                                              setState(() {
                                                custom_array.setAll(j, [
                                                  custom_drink(
                                                      img: custom_array[j].img,
                                                      name: bevName,
                                                      Status: '0')
                                                ]);
                                              });
                                            }
                                          }
                                        }
                                      }
    
                                      List<String> jsonList = fav_data_array
                                          .map((f_data) =>
                                              jsonEncode(f_data.toJson()))
                                          .toList();
                                      sp.setStringList('fevData', jsonList);
                                      sp.commit();
                                    } else {
                                      print('jhfd 3425');
                                    }
                                  
                                  },
                                ),
                              ] else ...[
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                    child: SvgPicture.asset("assets/unlike.svg"),
                                  ),
                                  onTap: () async {
                                    SharedPreferences sp =
                                        await SharedPreferences.getInstance();
    
                                    List<String> favData =
                                        sp.getStringList('fevData') ?? [];
    
                                    fav_data_array = favData
                                        .map((jsonString) => FavData.fromJson(
                                            jsonDecode(jsonString)))
                                        .toList();
    
                                    int a = fav_data_array.length;
    
                                    if (a <= 3) {
                                      String bevName = custom_array[index].name;
                                      fav_data_array.add(FavData(
                                          img: custom_array[index].img,
                                          name: custom_array[index].name,
                                          Status: '1'));
    
                                      for (int i = 0;
                                          i < custom_array.length;
                                          i++) {
                                        for (int j = 0;
                                            j < fav_data_array.length;
                                            j++) {
                                          if (fav_data_array[j].name ==
                                              custom_array[i].name) {
                                            setState(() {
    
                                              custom_array.setAll(i, [custom_drink(img: fav_data_array[j].img, name: fav_data_array[j].name, Status: fav_data_array[j].Status)]);
    
                                            });
                                          }
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Cannot select more than four bevrages')));
                                    }
    
                                    List<String> jsonList = fav_data_array
                                        .map((f_data) =>
                                            jsonEncode(f_data.toJson()))
                                        .toList();
                                    sp.setStringList('fevData', jsonList);
                                    sp.commit();
                                  },
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        )),
      ),
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
                          icon: Icon(
                            Icons.close,
                            color: Colors.blue,
                          )),
                    ),
                    Text("How Much Did You Drink Last?",
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
                                SizedBox(
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
                                    icon:
                                        Icon(Icons.remove, color: Colors.blue)),
                                SizedBox(
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
                                    icon: Icon(
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
                              undo_data(
                                  days, int.parse(water_value), current_date);
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
                            child: Text("UNDO",
                                style: TextStyle(fontFamily: "Open_sans")),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          TextButton(
                            onPressed: () {
                              int a = int.parse(widget.rem_value.toString()) +
                                  int.parse(water_value);
                              add_weekData(
                                  days, int.parse(water_value), current_date);
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
                            child: Text("ADD",
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

  void add_weekData(String day, int water_quantity, String date) async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    List<String> getList = pr.getStringList('week_data') ?? [];
    print('week  ' + getList.toString());
    if (!getList.isEmpty) {
      print('if week  ' + getList.toString());
      week_array = getList
          .map((jsonString) =>
              WeekWaterBarChartModel.fromJson(jsonDecode(jsonString)))
          .toList();
      print('week data ' + week_array.toString());
      print('week length ' + week_array.length.toString());
      if (week_array != 0) {
        print('week if');

        switch (day) {
          case 'Sun':
            if (week_array[0].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[0].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Mon':
            if (week_array[1].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[1].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Tue':
            if (week_array[2].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[2].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Wed':
            if (week_array[3].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[3].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Thu':
            if (week_array[4].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[4].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Fri':
            if (week_array[5].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri', water_quantity: water_quantity, wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[5].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri', water_quantity: abc, wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat',
                    water_quantity: week_array[6].water_quantity,
                    wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;

          case 'Sat':
            if (week_array[6].water_quantity == '0') {
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat', water_quantity: water_quantity, wtr_date: date)
              ]);
            } else {
              int abc = water_quantity + week_array[6].water_quantity;
              week_array.setAll(0, [
                WeekWaterBarChartModel(
                    days: 'Sun',
                    water_quantity: week_array[0].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(1, [
                WeekWaterBarChartModel(
                    days: 'Mon',
                    water_quantity: week_array[1].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(2, [
                WeekWaterBarChartModel(
                    days: 'Tue',
                    water_quantity: week_array[2].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(3, [
                WeekWaterBarChartModel(
                    days: 'Wed',
                    water_quantity: week_array[3].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(4, [
                WeekWaterBarChartModel(
                    days: 'Thu',
                    water_quantity: week_array[4].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(5, [
                WeekWaterBarChartModel(
                    days: 'Fri',
                    water_quantity: week_array[5].water_quantity,
                    wtr_date: date)
              ]);
              week_array.setAll(6, [
                WeekWaterBarChartModel(
                    days: 'Sat', water_quantity: abc, wtr_date: date)
              ]);
            }
            List<String> jsonList = week_array
                .map((week_data) => jsonEncode(week_data.toJson()))
                .toList();
            pr.setStringList('week_data', jsonList);
            pr.commit();
            break;
        }
      }
    } else {
      print('yes week else');
      switch (day) {
        case 'Sun':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();
          break;

        case 'Mon':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();

          break;

        case 'Tue':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();

          break;

        case 'Wed':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();

          break;

        case 'Thu':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();

          break;
        case 'Fri':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: water_quantity, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: 0, wtr_date: date));

          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();
          break;
        case 'Sat':
          week_array.add(WeekWaterBarChartModel(
              days: 'Sun', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Mon', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Tue', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Wed', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Thu', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Fri', water_quantity: 0, wtr_date: date));
          week_array.add(WeekWaterBarChartModel(
              days: 'Sat', water_quantity: water_quantity, wtr_date: date));
          List<String> jsonList = week_array
              .map((week_data) => jsonEncode(week_data.toJson()))
              .toList();
          pr.setStringList('week_data', jsonList);
          pr.commit();
          break;
      }
    }
  }

  void undo_data(String day, int water_quantity, String date) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> getList = pref.getStringList('week_data') ?? [];
    week_array = getList
        .map((jsonString) =>
            WeekWaterBarChartModel.fromJson(jsonDecode(jsonString)))
        .toList();
    switch (day) {
      case 'Sun':
        int abc = week_array[0].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Mon':
        int abc = week_array[1].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Tue':
        int abc = week_array[2].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Wed':
        int abc = week_array[3].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Thu':
        int abc = week_array[4].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Fri':
        int abc = week_array[5].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri', water_quantity: abc, wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat',
              water_quantity: week_array[6].water_quantity,
              wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;

      case 'Sat':
        int abc = week_array[6].water_quantity - water_quantity;
        week_array.setAll(0, [
          WeekWaterBarChartModel(
              days: 'Sun',
              water_quantity: week_array[0].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(1, [
          WeekWaterBarChartModel(
              days: 'Mon',
              water_quantity: week_array[1].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(2, [
          WeekWaterBarChartModel(
              days: 'Tue',
              water_quantity: week_array[2].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(3, [
          WeekWaterBarChartModel(
              days: 'Wed',
              water_quantity: week_array[3].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(4, [
          WeekWaterBarChartModel(
              days: 'Thu',
              water_quantity: week_array[4].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(5, [
          WeekWaterBarChartModel(
              days: 'Fri',
              water_quantity: week_array[5].water_quantity,
              wtr_date: date)
        ]);
        week_array.setAll(6, [
          WeekWaterBarChartModel(
              days: 'Sat', water_quantity: abc, wtr_date: date)
        ]);

        List<String> jsonList = week_array
            .map((week_data) => jsonEncode(week_data.toJson()))
            .toList();
        pref.setStringList('week_data', jsonList);
        pref.commit();
        break;
    }
  }
}
