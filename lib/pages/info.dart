import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_tracker/pages/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();

  @override
  void initState() {
    _weight.text = '';
    _height.text = '';


    super.initState();
  }

  bool _checkweight = true;
  bool _checkheight = true;
  bool screentype=true;

  bool toggleValue = false;
  bool visi = true,
      hour_1_visi = true,
      hour_1_5_visi = true,
      hour_2_visi = true;
  TimeOfDay _time = TimeOfDay(hour: 21, minute: 00);
  TimeOfDay _tym = TimeOfDay(hour: 9, minute: 00);
  String time_of_static = "21:00";
  String time = "9:00";
  String h = "";
  String index0 = "";
  String index1 = "0";
  String height = "cm";
  String weight = "lb";

  void _timepicker() {
    var arr = time_of_static.split(':');
    int first = int.parse(arr[0]);
    int second = int.parse(arr[1]);
    print('first ' + first.toString());
    print('second ' + second.toString());

    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: first, minute: second))
        .then((value) {
      setState(() {
        print(_time);
        _time = value!;
        setState(() {
          time_of_static =
              value.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
          print("timedddd " + time_of_static);
        });
        print('object time  ' +
            value.toString().replaceAll("TimeOfDay(", "").replaceAll(")", ""));
      });
    });
  }

  void _timeset() {
    var arr = time.split(':');
    int first = int.parse(arr[0]);
    int second = int.parse(arr[1]);
    print('firs ' + first.toString());
    print('second ' + second.toString());

    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: first, minute: second))
        .then((value) {
      setState(() {
        print(_tym);
        _tym = value!;
        setState(() {
          time =
              value.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
          print("timedddd " + time_of_static);
        });
        print('object time  ' +
            value.toString().replaceAll("TimeOfDay(", "").replaceAll(")", ""));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/sign_bg.png",
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.close,
                                  size: 25,
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                if (_checkweight == true) {
                                  double total_weight =
                                      double.parse(_weight.text) * 0.454;
                                  print("object hb  " + index1);

                                  double water_count = total_weight / 30;

                                  double total_target = water_count * 1000;
                                  double total_oz = (total_target * 0.038);
                                  String oz = total_oz.toStringAsFixed(0);
                                  String value =
                                      total_target.toStringAsFixed(0);
                                  //print("object"+oz);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("total_targets", value);
                                  prefs.setString("oz", oz);
                                   prefs.setBool('screen',screentype);
                                  prefs.commit();
                                } else {
                                  double total_weight =
                                      double.parse(_weight.text);
                                  print("object hb  " + index1);

                                  double water_count = total_weight / 30;

                                  double total_target = water_count * 1000;
                                  double total_oz = (total_target * 0.038);
                                  String oz = total_oz.toStringAsFixed(0);
                                  String value =
                                      total_target.toStringAsFixed(0);
                                  // print("object"+oz);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("total_targets", value);
                                  prefs.setString("oz", oz);
                                  prefs.setBool('screen',screentype);
                                  prefs.commit();
                                }
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (Context) => const mainscreen(
                                            access_from: 'info',
                                            cat_water_value: '')));
                              },
                              child: const Text(
                                "Done",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: const Text(
                        "Can You Please help Us With Some Information To Customer Experience For You?",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 19, 137, 233),
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Height",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              child: Stack(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: _height,
                                      decoration: const InputDecoration(
                                          hintText: "Height",
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.bottomRight,
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text("${height}"))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 40,
                            child: Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _checkheight = true;
                                        height = "cm";
                                      });
                                    },
                                    child: Visibility(
                                        visible:
                                            _checkheight == true ? false : true,
                                        child:
                                            SvgPicture.asset("assets/ft.svg"))),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _checkheight = false;
                                        height = "ft";
                                      });
                                    },
                                    child: Visibility(
                                        visible:
                                            _checkheight == true ? true : false,
                                        child:
                                            SvgPicture.asset("assets/cm.svg")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Weight",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              child: Stack(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: _weight,
                                      decoration: const InputDecoration(
                                          hintText: "Weight",
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.bottomRight,
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text("${weight}"))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 40,
                            child: Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _checkweight = true;
                                        weight = "lb";
                                      });
                                    },
                                    child: Visibility(
                                        visible:
                                            _checkweight == true ? false : true,
                                        child:
                                            SvgPicture.asset("assets/kg.svg"))),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _checkweight = false;
                                        weight = "kg";
                                      });
                                    },
                                    child: Visibility(
                                        visible:
                                            _checkweight == true ? true : false,
                                        child:
                                            SvgPicture.asset("assets/lb.svg")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Wakeup and Sleep Time",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _timeset();
                            },
                            child: Container(
                              height: 50,
                              // width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(_tym.format(context).toString())),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _timepicker();
                            },
                            child: Container(
                              height: 50,
                              //width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child:
                                      Text(_time.format(context).toString())),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Reminder Interval",
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 19, 137, 233)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    visi = false;
                                    hour_1_visi = true;
                                    hour_1_5_visi = true;
                                    hour_2_visi = true;
                                    h = "30 minutes";
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  // width: 140,
                                  decoration: BoxDecoration(
                                      color: visi == true
                                          ? Colors.white
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "30 MInutes",
                                    style: TextStyle(
                                      color: visi == true
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    visi = true;
                                    hour_1_visi = false;
                                    hour_1_5_visi = true;
                                    hour_2_visi = true;
                                    h = "1 hour";
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  //width: 140,
                                  decoration: BoxDecoration(
                                      color: hour_1_visi == true
                                          ? Colors.white
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "1 Hours",
                                    style: TextStyle(
                                        color: hour_1_visi == true
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    visi = true;
                                    hour_1_visi = true;
                                    hour_1_5_visi = false;
                                    hour_2_visi = true;
                                    h = "1 hour 30 minutes";
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  // width: 140,
                                  decoration: BoxDecoration(
                                      color: hour_1_5_visi == true
                                          ? Colors.white
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "1.5 Hours",
                                    style: TextStyle(
                                        color: hour_1_5_visi == true
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    visi = true;
                                    hour_1_visi = true;
                                    hour_1_5_visi = true;
                                    hour_2_visi = false;
                                    h = "2 hours";
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  // width: 140,
                                  decoration: BoxDecoration(
                                      color: hour_2_visi == true
                                          ? Colors.white
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text("2 Hours",
                                          style: TextStyle(
                                              color: hour_2_visi == true
                                                  ? Colors.black
                                                  : Colors.white))),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "During the non-break time,we will fire a remainder every ${h}",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
