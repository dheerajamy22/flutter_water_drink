import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class body_mass_index extends StatefulWidget {
  const body_mass_index({super.key});

  @override
  State<body_mass_index> createState() => _body_mass_indexState();
}

class _body_mass_indexState extends State<body_mass_index> {
  var height_controller = TextEditingController(text: '');
  var weight_controller = TextEditingController(text: '');
  bool man_icon = false, woman_icon = false;
  String bmi_status = '';
  String bmi_cal = '';
  double check = 0.0;
  String avg_weight = '';
  final Color _iconColor = Colors.blue;

  var height_type_array = ['cm', 'ft'];
  String height_type = 'cm';

  var weight_type_array = ['kg', 'lb'];
  String weight_type = 'kg';
  String w = '';
  String h = '';

  Future getHeight_WeightData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      w = prefs.getString('weight') ?? '';
      h = prefs.getString('height') ?? '';
      weight_controller.text = w;
      height_controller.text = h;
    });

    CalculateBMI();
  }

  @override
  void initState() {
    getHeight_WeightData();

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
                "BMI Calculator",
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: TextField(
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
                                                hintText: '25',
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Height',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: TextField(
                                              controller: height_controller,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
                                                hintText: '25',
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Container(
                                              height: 52,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButtonFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    border: InputBorder.none,
                                                  ),
                                                  //hint: Text('select'),
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  isDense: true,
                                                  isExpanded: true,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  value: height_type,
                                                  items: height_type_array
                                                      .map((String item) {
                                                    return DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item));
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      height_type = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          const Text(
                                            '',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                    child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      woman_icon = false;
                                                      man_icon = false;
                                                    });
                                                  },
                                                  color: man_icon == true
                                                      ? Colors.black
                                                      : Colors.blue,
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                    Icons.man,
                                                  ),
                                                )),
                                                Container(
                                                    height: 20,
                                                    width: 1,
                                                    color: Colors.black),
                                                InkWell(
                                                    child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      woman_icon = true;
                                                      man_icon = true;
                                                    });
                                                  },
                                                  color: woman_icon == false
                                                      ? Colors.black
                                                      : Colors.blue,
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                    Icons.woman,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Weight',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: TextField(
                                                controller: weight_controller,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  isDense: true,
                                                  hintText: '25',
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          const Text(
                                            '',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Container(
                                                height: 52,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child:
                                                      DropdownButtonFormField(
                                                    value: weight_type,
                                                    decoration:
                                                        const InputDecoration(
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            border: InputBorder
                                                                .none),
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    isDense: true,
                                                    isExpanded: true,
                                                    items: weight_type_array
                                                        .map((String item) {
                                                      return DropdownMenuItem(
                                                          value: item,
                                                          child: Text(item));
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        weight_type = value!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: InkWell(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text(
                                    'Calculate',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                onTap: () {
                                  CalculateBMI();
                                },
                              )),
                          if (bmi_status == 'Normal weight') ...[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: SvgPicture.asset(
                                'assets/normal_weight.svg',
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                              ),
                            )
                          ] else if (bmi_status == 'Under weight') ...[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: SvgPicture.asset(
                                'assets/under_weight.svg',
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                              ),
                            )
                          ] else if (bmi_status == 'Over weight') ...[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: SvgPicture.asset(
                                'assets/over_weight.svg',
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                              ),
                            )
                          ],
                          Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bmi_status,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.green),
                                ),
                                Text(
                                  "BMI: ${bmi_cal}",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Icon(Icons.arrow_right,color: Colors.green,),
                                      Text("Very Severely Underweight",
                                          style: TextStyle(
                                              color: check < 16.0
                                                  ? Colors.green
                                                  : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                    ],
                                  ),
                                  Text(
                                    "< 16.0",
                                    style: TextStyle(
                                        color: check < 16.0
                                            ? Colors.green
                                            : Colors.black,fontFamily: 'Open_sans',fontSize: 14),
                                  )
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Severely Underweight",
                                      style: TextStyle(
                                          color: (check < 16.9 && check > 16.0)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("16.0 - 16.9",
                                      style: TextStyle(
                                          color: (check < 16.9 && check > 16.0)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Underweight",
                                      style: TextStyle(
                                          color: (check < 18.5 && check > 16.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("17 - 18.4",
                                      style: TextStyle(
                                          color: (check < 18.5 && check > 16.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Normal",
                                      style: TextStyle(
                                          color: (check < 25.0 && check > 18.4)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("18.5 - 24.9",
                                      style: TextStyle(
                                          color: (check < 25.0 && check > 18.4)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Overweight",
                                      style: TextStyle(
                                          color: (check < 30.0 && check > 24.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("25.0 - 29.9",
                                      style: TextStyle(
                                          color: (check < 30.0 && check > 24.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Obese Class I",
                                      style: TextStyle(
                                          color: (check < 35.0 && check > 29.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("30.0 - 34.9",
                                      style: TextStyle(
                                          color: (check < 35.0 && check > 29.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Obese Class II",
                                      style: TextStyle(
                                          color: (check < 40.0 && check > 34.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text("35.0 - 39.9",
                                      style: TextStyle(
                                          color: (check < 40.0 && check > 34.9)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Obese Class III",
                                      style: TextStyle(
                                          color: (check > 40.0)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14)),
                                  Text(">= 40.0",
                                      style: TextStyle(
                                          color: (check > 40.0)
                                              ? Colors.green
                                              : Colors.black,fontFamily: 'Open_sans',fontSize: 14))
                                ],
                              ),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Normal Weight",style: TextStyle(fontFamily: 'Open_sans',fontSize: 14),),
                              Text(avg_weight,style: TextStyle(fontFamily: 'Open_sans',fontSize: 14)),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )                          
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void CalculateBMI() {
    if (height_type == 'cm') {
      if (height_controller.text != '' && weight_controller.text != '') {
        if (weight_type == 'kg') {
          var heightValue = int.parse(height_controller.text) / 100;
          var weightValue = int.parse(weight_controller.text);
          var bmi = weightValue / (heightValue * heightValue);
          calculateIdealWeight(bmi);
          setState(() {
            if (bmi < 18.5) {
              bmi_status = 'Under weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmi_status = 'Normal weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 25 && bmi <= 29.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 30 && bmi <= 34.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 35) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            }
          });
        } else {
          var heightValue = int.parse(height_controller.text) / 100;
          var weightValue = int.parse(weight_controller.text) * 0.454;
          var bmi = weightValue / (heightValue * heightValue);
          calculateIdealWeight(bmi);
          setState(() {
            if (bmi < 18.5) {
              bmi_status = 'Under weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmi_status = 'Normal weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 25 && bmi <= 29.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 30 && bmi <= 34.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 35) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            }
          });
        }
      }
    } else {
      if (height_controller.text != '' && weight_controller.text != '') {
        if (weight_type == 'kg') {
          double hegFt = double.parse(height_controller.text);
          var incm = hegFt * 30.48;
          var total_cm = incm.toStringAsFixed(0);
          var heightValue = int.parse(total_cm) / 100;
          var weightValue = int.parse(weight_controller.text);
          var bmi = weightValue / (heightValue * heightValue);
          calculateIdealWeight(bmi);
          setState(() {
            if (bmi < 18.5) {
              bmi_status = 'Under weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmi_status = 'Normal weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 25 && bmi <= 29.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 30 && bmi <= 34.9) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 35) {
              bmi_status = 'Over weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            }
          });
        } else {
          double hegFt = double.parse(height_controller.text);
          var incm = hegFt * 30.48;
          var total_cm = incm.toStringAsFixed(0);
          var heightValue = int.parse(total_cm) / 100;
          var weightValue = int.parse(weight_controller.text) * 0.454;
          var bmi = weightValue / (heightValue * heightValue);

          calculateIdealWeight(bmi);
          setState(() {
            if (bmi < 18.5) {
              bmi_status = 'Under weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmi_status = 'Normal weight';
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 25 && bmi <= 29.9) {
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_status = 'Over weight';
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 30 && bmi <= 34.9) {
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_status = 'Over weight';
              bmi_cal = bmi.toStringAsFixed(2);
            } else if (bmi >= 35) {
              check = double.parse(bmi.toStringAsFixed(2));
              bmi_status = 'Over weight';
              bmi_cal = bmi.toStringAsFixed(2);
            }
          });
        }
      }
    }
  }

  void calculateIdealWeight(double height) async {

    if (man_icon == false) {
      var height = double.parse(height_controller.text) - 152.4;

      var idealCalHeight = 0.91 * height;
      var ideal_weight = 50.0 + idealCalHeight;

      var minweight = ideal_weight * .9;
      var max_weight = ideal_weight * 1.1;

      print('min' +
          minweight.toStringAsFixed(2) +
          ' max ' +
          max_weight.toStringAsFixed(2));
          
      setState(() {
        print('hjkl;');
        avg_weight = minweight.toStringAsFixed(2) +' - '+max_weight.toStringAsFixed(2);
      });
    } else if (woman_icon == true) {
      var height = double.parse(height_controller.text) - 152.4;

      var idealCalHeight = 0.91 * height;
      var ideal_weight = 45.5 + idealCalHeight;

      var minweight = ideal_weight * .9;
      var max_weight = ideal_weight * 1.1;

      print('min' +
          minweight.toStringAsFixed(2) +
          ' max ' +
          max_weight.toStringAsFixed(2));

       setState(() {
        print('hjkl;');
        avg_weight = minweight.toStringAsFixed(2) +' - '+max_weight.toStringAsFixed(2);
      });
    }
  }
}
