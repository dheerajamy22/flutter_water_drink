import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/mainscreen.dart';

class adddrink extends StatefulWidget {
  final String rem_value;
  const adddrink({super.key, required this.rem_value});

  @override
  State<adddrink> createState() => _adddrinkState();
}

class _adddrinkState extends State<adddrink> {
  bool _visiblep = false, _visiblemilk = false, _visibleed = false, _visiblecold = false;
  bool _visiblec = false, _visiblem = false, _visibleco = false;
  double _slidervalue = 25;
  String water_value = '25';
  String oz_value = '0.8';
  String? target = '';
  String? oz = '';
  String oz_remain = '0';
  String water_data = "200";
  void getValue() async {
    SharedPreferences pr = await SharedPreferences.getInstance();

    setState(() {
      target = pr.getString('target');
      oz = pr.getString('oz');
    });
  }

  @override
  void initState() {
    getValue();

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/water.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Water",
                                      style: TextStyle(fontFamily: "Open_sans"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: SvgPicture.asset("assets/filledlike.svg"),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/coconutwater.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Coconut Water",
                                      style: TextStyle(fontFamily: "Open_sans"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _visiblec = true;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Visibility(
                                          child: SvgPicture.asset(
                                              "assets/unlike.svg")),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              _visiblec = false;
                                            });
                                          },
                                          child: Visibility(
                                              visible: _visiblec,
                                              child: SvgPicture.asset(
                                                  "assets/filledlike.svg"))),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/colddrink.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Cold Drink",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                          setState(() {
                                            _visiblecold = true;
                                          });
                                        },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                           Visibility(
                                      visible: _visiblecold,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visiblecold = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/cocktail.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("CockTail",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _visibleco = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                  Visibility(
                                      visible: _visibleco,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visibleco = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/energydrink.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Energy Drink",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _visibleed = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                  Visibility(
                                      visible: _visibleed,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visibleed = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/milk.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Milk",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _visiblemilk = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                  Visibility(
                                      visible: _visiblemilk,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visiblemilk = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/mocktail.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Mocktail",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _visiblem = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                  Visibility(
                                      visible: _visiblem,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visiblem = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addDrinkDilog();
                              },
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 168, 211, 247)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/proteinshake.svg"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Protein Shake",
                                        style:
                                            TextStyle(fontFamily: "Open_sans"))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 120, top: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _visiblep = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/unlike.svg")),
                                  Visibility(
                                      visible: _visiblep,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _visiblep = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/filledlike.svg"),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
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
