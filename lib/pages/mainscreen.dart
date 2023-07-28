import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/adddrink.dart';
import 'package:water_tracker/pages/water_bar_charts/water_week_array.dart';
import 'package:water_tracker/pages/water_bar_charts/waterbar.dart';
import 'package:water_tracker/pages/profile.dart';
import 'package:water_tracker/pages/stepcounter.dart';
import 'custom_drink/fav_data.dart';
import 'water_bar_charts/waterbarChartModel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class mainscreen extends StatefulWidget {
  final String access_from, cat_water_value;
  const mainscreen({
    super.key,
    required this.access_from,
    required this.cat_water_value,
  });

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  double _slidervalue = 25;
  String water_value = '25';
  String oz_value = '0.8';
  String _remeaing_value = '0';
  String _percent = '0';
  String? target = '';
  String? oz = '';
  String oz_remain = '0';
  final DateTime date = DateTime.now();
  String current_date = '';
  String days = '';
  String saveDays = '';
  late AudioPlayer player;
  List<WeekWaterBarChartModel> week_array = [];
  List<FavData> fav_data_array = [];
  String pre_day='';

// ignore: non_constant_identifier_names

  void getValue() async {
    //SharedPreference getting value with the help of key
    SharedPreferences pr = await SharedPreferences.getInstance();

    List<String> favData = pr.getStringList('fevData') ?? [];

    fav_data_array =
        favData.map((e) => FavData.fromJson(jsonDecode(e))).toList();
    //_remeaing_value=pr.getString('achieved').toString();
      String? pre_day = pr.getString('days');
    days = DateFormat('EEE').format(date);
    print("abcdefghi" + days);
    print(favData.length);
    setState(() {
      target = pr.getString('total_targets');
      print('re ' + target.toString());
      oz = pr.getString('oz');
      // pr.setString('day', days);
      pr.setString('saveDays', days);
      if (widget.access_from == 'add_drink') {
        int int_rem = int.parse(widget.cat_water_value);

        double oztotal = int_rem * 0.038;
        oz_remain = oztotal.toStringAsFixed(0);

        _remeaing_value = int_rem.toString();
        pr.setString('achived', _remeaing_value);
        pr.setString('oz_remain', oz_remain);

        double tar = double.parse(target.toString());
        double per = (int_rem / tar) * 100;
        _percent = per.toStringAsFixed(0);
        pr.setString("_percent", _percent);
        int p = int.parse(_percent);
        if (p < 100) {
        } else {
          _percent = "100";
        }

        List<WaterBarChartModel> water_data = [];

        List<String> getListAlready = pr.getStringList('salesList') ?? [];
        print('object  ' + getListAlready.toString());

        String? saveday = pr.getString('saveDays');
        print('dys ' + saveday.toString());
        if (getListAlready == 0) {
          water_data.add(WaterBarChartModel(
              days: days, water_quantity: int_rem, wtr_date: current_date));
        } else {
          setState(() {
            water_data = getListAlready
                .map((jsonString) =>
                    WaterBarChartModel.fromJson(jsonDecode(jsonString)))
                .toList();
          });

          if (water_data.length != 0) {
            if (water_data[water_data.length - 1].days == saveday) {
              int a = water_data.length - 1;
              //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));

              water_data.setAll(a, [
                WaterBarChartModel(
                    days: water_data[a].days,
                    water_quantity: int_rem,
                    wtr_date: current_date)
              ]);
              print('right');
            } else {
              water_data.add(WaterBarChartModel(
                  days: days, water_quantity: int_rem, wtr_date: current_date));
              print('wrong');
            }
          } else {
            water_data.add(WaterBarChartModel(
                days: days, water_quantity: int_rem, wtr_date: current_date));
          }
          print('werytuiop');
          List<String> jsonList = water_data
              .map((sales_list) => jsonEncode(sales_list.toJson()))
              .toList();
          pr.setStringList('salesList', jsonList);
          pr.commit();

          print('object' + water_data.toString());
        }
      } else if (widget.access_from == 'info') {
        _remeaing_value = '0';
      } else {
        setState(() {
          _remeaing_value = "0";
          oz_remain = "0";
          _remeaing_value = pr.getString('achived') ?? '';
          oz_remain = pr.getString('oz_remain') ?? '';
          _percent = pr.getString('_percent') ?? '';
          print('vhnbm,z xnjbxnbnj');

          if (_remeaing_value == '') {
            _remeaing_value = '0';
          }
          if (oz_remain == '') {
            oz_remain = '0';
          }
          if (_percent == '') {
            _percent = '0';
          }

          print('data check from other' + _remeaing_value);
        });
      }
    });
      print('hjmcsc  ' + pre_day!);
    print(pre_day);
    if (pre_day != days) {
      setState(() {
        _remeaing_value = '0';
        pr.setString('achived', '0');
        pr.setString('oz_remain', '0');
        pr.setString('_percent', '0');
        pre_day = days;
        print('hjmcsc7  ' + pre_day!);
        pr.commit();
      });
      print(_remeaing_value);
    }
  }

  @override
  void initState() {
    getValue();
    player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));
    current_date = DateFormat('MM-dd').format(date);

    print(current_date);
    print(days);
    print(date.day);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        body: Scaffold(
            body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/sign_bg.png"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile()));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Stack(children: [
                                Image.asset(
                                  "assets/drop.png",
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 110),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _percent,
                                              style: const TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.white),
                                            ),
                                            const Text("%",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily: "Open_sans"))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Center(
                                        child: Text(
                                          "Achieve Goals",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontFamily: "Open_sans"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Achieved ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Open_sans"),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(_remeaing_value + " ml",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontFamily: "Open_sans")),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(oz_remain + " oz",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontFamily: "Open_sans"))
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 60,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              const Text("Target",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontFamily: "Open_sans")),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(target.toString() + " ml",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontFamily: "Open_sans")),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(oz.toString() + " oz",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontFamily: "Open_sans"))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                        if (!fav_data_array.isEmpty) ...[
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () async {
                                          addDrinkDilog();
                                        },

                                        //
                                        child: Container(
                                          height: 58,
                                          child: Card(
                                            elevation: 4,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: const EdgeInsets.only(
                                                      top: 4, right: 6),
                                                  child: SvgPicture.asset(
                                                    'assets/filledlike.svg',
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          fav_data_array[0].img,
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                         Text(
                                                          fav_data_array[0].name,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Open_sans"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: InkWell(
                                          onTap: () async {
                                            addDrinkDilog();
                                          },
                                          child: Container(
                                            height: 58,
                                            child: Card(
                                              elevation: 4,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 4, right: 6),
                                                    child: SvgPicture.asset(
                                                      'assets/filledlike.svg',
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            fav_data_array[1].img,
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                           Text(
                                                            fav_data_array[1].name,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Open_sans"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () async {
                                          addDrinkDilog();
                                        },
                                        child: Container(
                                          height: 58,
                                          child: Card(
                                            elevation: 4,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: const EdgeInsets.only(
                                                      top: 4, right: 6),
                                                  child: SvgPicture.asset(
                                                    'assets/filledlike.svg',
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          fav_data_array[2].img,
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                         Text(
                                                          fav_data_array[2].name,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Open_sans"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        onTap: () async {
                                          addDrinkDilog();
                                        },
                                        child: Container(
                                          height: 58,
                                          child: Card(
                                            elevation: 4,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: const EdgeInsets.only(
                                                      top: 4, right: 6),
                                                  child: SvgPicture.asset(
                                                    'assets/filledlike.svg',
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          fav_data_array[3].img,
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                         Text(
                                                          fav_data_array[3].name,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Open_sans"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ] else ...[
                         
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: InkWell(
                                          onTap: () async {
                                            addDrinkDilog();
                                          },

                                          //
                                          child: Container(
                                            height: 58,
                                            child: Card(
                                              elevation: 4,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 4, right: 6),
                                                    child: SvgPicture.asset(
                                                      'assets/filledlike.svg',
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/water.svg",
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text(
                                                            "Water",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Open_sans"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: InkWell(
                                            onTap: () async {
                                              addDrinkDilog();
                                            },
                                            child: Container(
                                              height: 58,
                                              child: Card(
                                                elevation: 4,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topRight,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 4, right: 6),
                                                      child: SvgPicture.asset(
                                                        'assets/filledlike.svg',
                                                        width: 12,
                                                        height: 12,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/milk.svg",
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Text(
                                                              "Milk",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      "Open_sans"),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: InkWell(
                                          onTap: () async {
                                            addDrinkDilog();
                                          },
                                          child: Container(
                                            height: 58,
                                            child: Card(
                                              elevation: 4,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 4, right: 6),
                                                    child: SvgPicture.asset(
                                                      'assets/filledlike.svg',
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/coconutwater.svg",
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text(
                                                            "Coconut Water",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Open_sans"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: InkWell(
                                          onTap: () async {
                                            addDrinkDilog();
                                          },
                                          child: Container(
                                            height: 58,
                                            child: Card(
                                              elevation: 4,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 4, right: 6),
                                                    child: SvgPicture.asset(
                                                      'assets/filledlike.svg',
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/energydrink.svg",
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'Energy drink',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Open_sans"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]
                       
                      ],
                    ) // const SizedBox(
                    //   height: 40,
                    // ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => adddrink(
                                          rem_value: _remeaing_value)));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: CircleAvatar(
                                radius: 25,
                                child: SvgPicture.asset(
                                  "assets/addwater.svg",
                                  fit: BoxFit.fill,
                                  // color: Colors.white,
                                ),
                              ),
                            )),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35,
                          child: Image.asset(
                            "assets/blue_glass.png",
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              //sharedPrefrence assigning key and value
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("target", _remeaing_value);
                              prefs.commit();

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyBarChart()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: SvgPicture.asset(
                                  "assets/statistics.svg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 32, right: 32),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StepCounterPage()));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: SvgPicture.asset(
                                "assets/steps.svg",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )),
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
                    Text(
                      "How Much Did You Drink Last?",
                      style: TextStyle(fontFamily: "Open_sans"),
                    ),
                    StatefulBuilder(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  water_value + " ml",
                                  style: TextStyle(fontFamily: "Open_sans"),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  oz_value + " oz",
                                  style: TextStyle(fontFamily: "Open_sans"),
                                ),
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
                              min: 0,
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
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                state(
                                  () {
                                    int int_water = int.parse(water_value);
                                    int rem = int.parse(_remeaing_value);

                                    if (rem >= int_water) {
                                      int total = rem - int_water;
                                      _remeaing_value = total.toString();
                                      double oztotal = total * 0.038;
                                      oz_remain = oztotal.toStringAsFixed(0);
                                      pref.setString(
                                          'achived', _remeaing_value);
                                      pref.setString('oz_remain', oz_remain);
                                      double tar =
                                          double.parse(target.toString());

                                      double per = (total / tar) * 100;
                                      _percent = per.toStringAsFixed(0);
                                      pref.setString("_percent", _percent);
                                      print('object');
                                      int a = int.parse(_percent);
                                      print('vbn ' + a.toString());

                                      List<WaterBarChartModel> water_data = [];

                                      List<String> getListAlready =
                                          pref.getStringList('salesList') ?? [];
                                      print('object  ' +
                                          getListAlready.toString());

                                      String? saveday =
                                          pref.getString('saveDays');
                                      print('dys ' + saveday.toString());
                                      if (getListAlready == 0) {
                                        water_data.add(WaterBarChartModel(
                                            days: days,
                                            water_quantity: int_water,
                                            wtr_date: current_date));
                                      } else {
                                        setState(() {
                                          water_data = getListAlready
                                              .map((jsonString) =>
                                                  WaterBarChartModel.fromJson(
                                                      jsonDecode(jsonString)))
                                              .toList();
                                        });
                                        undo_data(
                                            days, int_water, current_date);
                                        if (water_data.length != 0) {
                                          if (water_data[water_data.length - 1]
                                                  .days ==
                                              saveday) {
                                            int a = water_data.length - 1;
                                            //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));
                                            int c =
                                                water_data[a].water_quantity -
                                                    int_water;
                                            print(c);
                                            water_data.setAll(a, [
                                              WaterBarChartModel(
                                                  days: water_data[a].days,
                                                  water_quantity: c,
                                                  wtr_date: current_date)
                                            ]);
                                            print('right');
                                          } else {
                                            water_data.add(WaterBarChartModel(
                                                days: days,
                                                water_quantity: int_water,
                                                wtr_date: current_date));
                                            print('wrong');
                                          }
                                        } else {
                                          water_data.add(WaterBarChartModel(
                                              days: days,
                                              water_quantity: int_water,
                                              wtr_date: current_date));
                                        }
                                        print('werytuiop');
                                        List<String> jsonList = water_data
                                            .map((sales_list) =>
                                                jsonEncode(sales_list.toJson()))
                                            .toList();
                                        pref.setStringList(
                                            'salesList', jsonList);
                                        pref.commit();

                                        print('object' + water_data.toString());
                                      }

                                      if (a < 100) {
                                      } else {
                                        _percent = '100';
                                      }

                                      Navigator.of(context).pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please select valid value')));
                                    }
                                  },
                                );
                              });
                            },
                            child: Text(
                              "UNDO",
                              style: TextStyle(fontFamily: "Open_sans"),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                state(() {
                                  print('sd' + _remeaing_value);
                                  print('sd' + water_value);
                                  int int_rem = int.parse(_remeaing_value);
                                  int int_water = int.parse(water_value);
                                  int total = int_rem + int_water;
                                  double oztotal = total * 0.038;
                                  oz_remain = oztotal.toStringAsFixed(0);

                                  _remeaing_value = total.toString();
                                  pref.setString('achived', _remeaing_value);
                                  pref.setString('oz_remain', oz_remain);

                                  print('sd' + _remeaing_value);
                                  double tar = double.parse(target.toString());
                                  double per = (total / tar) * 100;
                                  _percent = per.toStringAsFixed(0);
                                  pref.setString("_percent", _percent);
                                  print('sd' + _percent);
                                  print('object');
                                  int a = int.parse(_percent);
                                  print('vbn ' + a.toString());
                                  if (a < 100) {
                                  } else {
                                    _percent = '100';
                                  }

                                  List<WaterBarChartModel> water_data = [];

                                  List<String> getListAlready =
                                      pref.getStringList('salesList') ?? [];
                                  print('object  ' + getListAlready.toString());

                                  String? saveday = pref.getString('saveDays');
                                  print('dys ' + saveday.toString());
                                  if (getListAlready == 0) {
                                    water_data.add(WaterBarChartModel(
                                        days: days,
                                        water_quantity: int_water,
                                        wtr_date: current_date));
                                  } else {
                                    setState(() {
                                      water_data = getListAlready
                                          .map((jsonString) =>
                                              WaterBarChartModel.fromJson(
                                                  jsonDecode(jsonString)))
                                          .toList();
                                    });

                                    if (water_data.length != 0) {
                                      if (water_data[water_data.length - 1]
                                              .days ==
                                          saveday) {
                                        int a = water_data.length - 1;
                                        //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));
                                        int c = int_water +
                                            water_data[a].water_quantity;

                                        water_data.setAll(a, [
                                          WaterBarChartModel(
                                              days: water_data[a].days,
                                              water_quantity: c,
                                              wtr_date: current_date)
                                        ]);
                                        print('right');
                                      } else {
                                        water_data.add(WaterBarChartModel(
                                            days: days,
                                            water_quantity: int_water,
                                            wtr_date: current_date));
                                        print('wrong');
                                      }
                                    } else {
                                      water_data.add(WaterBarChartModel(
                                          days: days,
                                          water_quantity: int_water,
                                          wtr_date: current_date));
                                    }
                                    print('werytuiop');
                                    List<String> jsonList = water_data
                                        .map((sales_list) =>
                                            jsonEncode(sales_list.toJson()))
                                        .toList();
                                    pref.setStringList('salesList', jsonList);
                                    pref.commit();

                                    print('object' + water_data.toString());
                                  }
                                  add_weekData(days, int_water, current_date);
                                  // water_data.add(BarChartModel(days: days, water_quantity: int_water, wtr_date: current_date));

                                  if (_percent == 100) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "You Achieved Your Target")));
                                  }
                                });
                              });
                              // player.play(AssetSource("assets/audio/water_drop.mp3"));
                              AssetsAudioPlayer.newPlayer().open(
                                Audio("assets/audio/water_drop.mp3"),
                                autoStart: true,
                                showNotification: false,
                              );
                              Navigator.of(context).pop(context);
                            },
                            child: Text(
                              "ADD",
                              style: TextStyle(fontFamily: "Open_sans"),
                            ),
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
