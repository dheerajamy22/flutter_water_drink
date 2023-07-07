import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:water_tracker/pages/Insight.dart';
import 'package:water_tracker/pages/step_bar_chart/stepbarchartmodel.dart';

class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  late Stream<StepCount> _stepCountStream;
  int _initialStepCount = 0;
  int _currentStepCount = 0;
  double _per = 0.0, _per_cal = 0.0, _per_dis = 0.0, _per_min = 0.0;
  String dis = "0", cal = "0", min = '0';
  final DateTime date = DateTime.now();
  String current_date = '';
  String days = '';

  @override
  void initState() {
    super.initState();
    _loadInitialStepCount();
    _startListening();
  }
//   void stepbar()async{
//     SharedPreferences pr=await SharedPreferences.getInstance();
//     print("steps");
//     print(_currentStepCount);

// setState(() {

//         String? saveday = pr.getString('saveDays');
//         print('dys ' + saveday.toString());
//         if (stepgetListAlready == 0) {
//           Step_data.add(StepBarChartModel(
//               days: days, steps: _currentStepCount, step_date: current_date));
//         } else {
//           setState(() {
//             Step_data = stepgetListAlready
//                 .map((jsonString) =>
//                     StepBarChartModel.fromJson(jsonDecode(jsonString)))
//                 .toList();
//           });

//           if (Step_data.length != 0) {
//             if (Step_data[Step_data.length - 1].days == saveday) {
//               int a = Step_data.length - 1;
//               //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));

//               Step_data.setAll(a, [
//                 StepBarChartModel(
//                     days: Step_data[a].days,
//                     steps: _currentStepCount,
//                     step_date: current_date)
//               ]);
//               print('right');
//             } else {
//               Step_data.add(StepBarChartModel(
//                   days: days, steps: _currentStepCount, step_date: current_date));
//               print('wrong');
//             }
//           } else {
//             Step_data.add(StepBarChartModel(
//                 days: days, steps: _currentStepCount, step_date: current_date));
//           }
//           print('werytuiop');
//           List<String> jsonList = Step_data
//               .map((sales_list) => jsonEncode(sales_list.toJson()))
//               .toList();
//           pr.setStringList('salesList', jsonList);
//           pr.commit();

//           print('object' + Step_data.toString());
//         }

// });

//   }

  void _loadInitialStepCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _initialStepCount = prefs.getInt('stepCount') ?? 0;
    });
  }

  void _startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount);
  }

  void _onStepCount(StepCount event) async {
    setState(() {
      if (_initialStepCount == 0) {
        _initialStepCount = event.steps;
        print("abc  " + _initialStepCount.toString());
      } else {
        _currentStepCount = event.steps - _initialStepCount;
        print("def  " + _currentStepCount.toString());
      }
    });
    //  stepbar();
    current_date = DateFormat('yyyy-MM-dd').format(date);
    days = DateFormat('EEE').format(date);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('stepCount', _initialStepCount);
    String? saveday = prefs.getString('saveDays');

    print('daaaaiyidaifiydfdl   '+saveday.toString());
    List<StepBarChartModel> Step_data = [];
    List<String> stepgetListAlready = prefs.getStringList('stepList') ?? [];

    int a = stepgetListAlready.length;

    if (a == 0) {
      Step_data.add(StepBarChartModel(
          days: days, steps: _currentStepCount, step_date: current_date));
      print('ertftcjcj  1');
    }
    // } else if (Step_data[Step_data.length - 1].days != saveday) {
    //   Step_data.add(StepBarChartModel(
    //       days: days, steps: _currentStepCount, step_date: current_date));
    //       print('ertftcjcj  2');
    // }
    else {
         setState(() {
          Step_data = stepgetListAlready
              .map((jsonString) =>
                  StepBarChartModel.fromJson(jsonDecode(jsonString)))
              .toList();
        });
      if (a != 0) {
     
        if (Step_data[Step_data.length - 1].days == saveday) {
          int a = Step_data.length - 1;
              //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));

              Step_data.setAll(a, [
                StepBarChartModel(
                    days: Step_data[a].days,
                    steps: _currentStepCount,
                    step_date: current_date)
              ]);
              print('right');
        } else {
                Step_data.add(StepBarChartModel(
          days: days, steps: _currentStepCount, step_date: current_date));
        }
      }else{
          Step_data.add(StepBarChartModel(
          days: days, steps: _currentStepCount, step_date: current_date));
      }
    
    }
    List<String> jsonList =
        Step_data.map((sales_list) => jsonEncode(sales_list.toJson())).toList();
    prefs.setStringList('stepList', jsonList);
    // prefs.commit();

    //here we find total  percentage with respect to total 6000 steps
    _per = (_currentStepCount / 6000) * 100;
    print(_per);

    //here we find total Cal of 6000 steps and Cal per steps and percentage
    double total_cal = 6000 * 0.04;
    cal = (_currentStepCount * 0.04).toStringAsFixed(2);
    _per_cal = (double.parse(cal) / total_cal) * 100;

    //here we find total dis of 6000 steps and dis per steps and percentage
    double total_distance = 6000 / 1312.33595801;
    dis = (_currentStepCount / 1312.33595801).toStringAsFixed(2);
    _per_dis = (double.parse(dis) / total_distance) * 100;

    //here we find total min of 6000 steps and min per steps and percentage
    double total_min = (6000 / 100);
    min = (_currentStepCount / 100).toStringAsFixed(2);
    _per_min = (double.parse(min) / total_min) * 100;

    prefs.setString("calories", cal);
    prefs.setString('distance', dis);
    prefs.setDouble('per_cal', _per_cal);
    prefs.setDouble('per_dis', _per_dis);
    prefs.setDouble('per_step', _per);
    prefs.setInt("step", _currentStepCount);
    prefs.commit();
  }

  @override
  void dispose() {
    super.dispose();
    _stopListening();
  }

  void _stopListening() async {
    _stepCountStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              //this is the starting of row in which back and insight button are declared
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  const Text(
                    "Step Counter",
                    style: TextStyle(fontFamily: "Open_sans", fontSize: 14,),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => insight()));
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "Insight",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Open_sans"),
                      ),
                    ),
                  )
                ],
              ),
              //this is the ending of row in which back and insight button are declared

              //this is the starting of percent indicator and steps block
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      //percent indicator block starting
                      Container(
                        alignment: Alignment.center,
                        child: CircularPercentIndicator(
                          radius: 120,
                          animation: true,
                          animationDuration: 1000,
                          lineWidth: 10,
                          percent: _per / 100,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade100,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ),
                      //percent indicator block starting

                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/steps.svg",
                              height: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$_currentStepCount',
                              style: const TextStyle(
                                  fontSize: 24, fontFamily: "Open_sans"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Steps",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "Open_sans"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //this is the starting of percent indicator and steps block
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$_currentStepCount / 6000',
                  style: TextStyle(fontSize: 24, fontFamily: "Open_sans"),
                ),
              ),

              //Starting of time ,cal and dis block
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //start of cal block
                      Flexible(
                        child: Container(
                          height: 90,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 5,
                                  percent: _per_cal / 100,
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.blue.shade100,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/calorie.svg",
                                  width: 25,
                                  height: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //ending of cal block

                      //start of time block
                      Flexible(
                        child: Container(
                          height: 90,
                          //   width: 90,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 5,
                                  percent: _per_dis / 100,
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.blue.shade100,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/timing.svg",
                                  height: 25,
                                  width: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //end of time block

                      //start of dis block
                      Flexible(
                        child: Container(
                          height: 90,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 5,
                                  percent: _per_min / 100,
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.blue.shade100,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/distance.svg",
                                    height: 25, width: 25),
                              )
                            ],
                          ),
                        ),
                      )
                      //end of dis block
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("$cal Kcal",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "Open_sans")),
                      Text("$min Min",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "Open_sans")),
                      Text("$dis Km",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "Open_sans"))
                    ],
                  )
                ],
              )
              //Starting of time ,cal and dis block
            ],
          ),
        ),
      ),
    );
  }
}
