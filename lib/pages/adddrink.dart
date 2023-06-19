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
  bool _visiblep = false;
  bool _visiblec = false;
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
    return Scaffold(
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
                style: TextStyle(fontSize: 20, color: Colors.white),
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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/water.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Water")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/coconutwater.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Coconut Water")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/colddrink.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Cold Drink")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: SvgPicture.asset("assets/unlike.svg"),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/cocktail.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("CockTail")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: SvgPicture.asset("assets/unlike.svg"),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/energydrink.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Energy Drink")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: SvgPicture.asset("assets/unlike.svg"),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/milk.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Milk")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: SvgPicture.asset("assets/unlike.svg"),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/mocktail.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Mocktail")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: SvgPicture.asset("assets/unlike.svg"),
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
                                  color:
                                      const Color.fromARGB(255, 168, 211, 247)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/proteinshake.svg"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text("Protein Shake")
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 120, top: 10),
                            child: Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _visiblep = true;
                                      });
                                    },
                                    child:
                                        SvgPicture.asset("assets/unlike.svg")),
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
    ));
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
                    const Text("How Much Did You Drink Last?"),
                    StatefulBuilder(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(water_value + " ml"),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(oz_value + " oz"),
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
                                      cat_water_value: a.toString(),)));

                              // setState(() {
                              //   state(
                              //     () {
                              //       int watr = int.parse(water_value);
                              //       int rem = int.parse(_remeaing_value);

                              //       if (rem >= watr) {
                              //         int total = rem - watr;
                              //         _remeaing_value = total.toString();
                              //         double tar =
                              //             double.parse(target.toString());
                              //         double per = (total / tar) * 100;
                              //         _percent = per.toStringAsFixed(0);
                              //         Navigator.of(context).pop(context);
                              //       } else {
                              //         ScaffoldMessenger.of(context)
                              //             .showSnackBar(SnackBar(
                              //                 content: Text(
                              //                     'Please select valid value')));
                              //       }
                              //     },
                              //   );
                              // });
                            },
                            child: Text("UNDO"),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          TextButton(
                            onPressed: () {
                              int a = int.parse(widget.rem_value.toString()) +
                                  int.parse(water_value);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => new mainscreen(
                                      access_from: 'add_drink',
                                      cat_water_value: a.toString(),)));
                              // int int_rem = int.parse(_remeaing_value);
                              // int int_water = int.parse(water_value);
                              // int total = int_rem + int_water;
                              // double oztotal = total * 0.038;
                              // oz_remain = oztotal.toStringAsFixed(0);

                              // _remeaing_value = total.toString();
                              // double tar = double.parse(target.toString());
                              // double per = (total / tar) * 100;
                              // _percent = per.toStringAsFixed(0);
                              // if (_percent == 100) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: Text(
                              //               "You Achieved Your Target")));
                              // }

                              //Navigator.of(context).pop(context);
                            },
                            child: Text("ADD"),
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
