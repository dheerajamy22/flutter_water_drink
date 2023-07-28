import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_tracker/pages/step_bar_chart/step_week_array.dart';
import 'package:water_tracker/pages/step_bar_chart/stepbarchartmodel.dart';

class insight extends StatefulWidget {
  const insight({super.key});

  @override
  State<insight> createState() => _insightState();
}

class _insightState extends State<insight> {
  double _per = 0.0, _per_cal = 0.0, _per_dis = 0.0;
  String dis = "0", cal = "0", min = '0';
  int steps = 0;
  bool wm=true,_visi=true;
  List<WeekStepBarChartModel> step_data = [];
  List<StepBarChartModel> sdata = [];
  void dataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> getList = pref.getStringList('stepList') ?? [];
    print('object sfdg  ' + getList.toString());

   
      
    setState(() {
      sdata = getList
          .map((jsonString) =>
              StepBarChartModel.fromJson(jsonDecode(jsonString)))
          .toList();
    });

    print('object w ' + sdata.toString());

      List<String> week = pref.getStringList('step_data') ?? [];
    print('object  ' + week.toString());

    setState(() {
      step_data = week
          .map((jsonString) =>
              WeekStepBarChartModel.fromJson(jsonDecode(jsonString)))
          .toList();
    });
    
  }

  void getvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _per = prefs.getDouble('per_step')!;
      _per_cal = prefs.getDouble('per_cal')!;
      _per_dis = prefs.getDouble("per_dis")!;
      cal = prefs.getString("calories")!;
      dis = prefs.getString("distance")!;
      steps = prefs.getInt("step")!;
    });
  }

  @override
  void initState() {
    getvalue();
    dataList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //dataList();
    return WillPopScope(
      onWillPop: () async=> false,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "Insight",
                    style: TextStyle(fontFamily: "Open_sans", fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                child: const Text(
                  "Today",
                  style: TextStyle(fontSize: 18, fontFamily: "Open_sans"),
                )),
            const SizedBox(
              height: 10,
            ),
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
                                percent: _per / 100,
                                progressColor: Colors.blue,
                                backgroundColor: Colors.blue.shade100,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/steps.svg",
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
                                percent: _per_cal / 100,
                                progressColor: Colors.blue,
                                backgroundColor: Colors.blue.shade100,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/calorie.svg",
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
                                percent: _per_dis / 100,
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
                    Text("$steps Steps",
                        style:
                            TextStyle(fontSize: 16, fontFamily: "Open_sans")),
                    Text("$cal Kcal",
                        style:
                            TextStyle(fontSize: 16, fontFamily: "Open_sans")),
                    Text("$dis Km",
                        style: TextStyle(fontSize: 16, fontFamily: "Open_sans"))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 228, 228),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          wm=true;
                           _visi=true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                          decoration:  BoxDecoration( color: wm==true?Colors.blue:Colors.grey,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                          ),
                          child:  Text(
                            "Weekly",
                            style: TextStyle(color: wm == true?Colors.white:Colors.black,fontSize: 16, fontFamily: "Open_sans" ),
                          )),
                    ),
                  ),
                  Flexible(
                      child: InkWell(
                        onTap: () {
                         setState(() {
                            wm=false;
                            _visi=false;
                         });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                          color: wm==false?Colors.blue:Colors.grey,
                          ),
                            child:  Text(
                                            "Monthly",
                                            style: TextStyle(color: wm == false?Colors.white:Colors.black,fontSize: 16, fontFamily: "Open_sans" ),
                                          )),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Visibility(
              visible:_visi ,
              child: SfCartesianChart(
                  //primaryXAxis: CategoryAxis(),
                  enableAxisAnimation: true,
                  // Chart title
                  title: ChartTitle(text: ''),
                  // Enable legend
                  legend: Legend(isVisible: false),
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(fontSize: 14),
                    maximumLabels: 100,
                    autoScrollingDelta: 7,
                    majorGridLines: MajorGridLines(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                      //  numberFormat: NumberFormat('##########人'),
                      minimum: 1.0,
                      majorGridLines: MajorGridLines(
                        width: 0,
                      )),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                  ),
                
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <ChartSeries<WeekStepBarChartModel, String>>[
                    StackedColumnSeries<WeekStepBarChartModel, String>(
                        dataSource: step_data,
                        xValueMapper: (WeekStepBarChartModel steps, _) => steps.days,
                        yValueMapper: (WeekStepBarChartModel sales1, _) =>
                            sales1.steps,
                        name: 'Record',
                        width: 0.3,
                        spacing: 0.1,
                        emptyPointSettings: EmptyPointSettings(
                            // Mode of empty point
                            mode: EmptyPointMode.average),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false)),
                  ]),
            ),
            Visibility(
              visible: _visi==false?true:false,
              child: SfCartesianChart(
                  //primaryXAxis: CategoryAxis(),
                  enableAxisAnimation: true,
                  // Chart title
                  title: ChartTitle(text: ''),
                  // Enable legend
                  legend: Legend(isVisible: false),
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(fontSize: 14),
                    maximumLabels: 100,
                    autoScrollingDelta: 6,
                    majorGridLines: MajorGridLines(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                      //  numberFormat: NumberFormat('##########人'),
                      minimum: 1.0,
                      majorGridLines: MajorGridLines(
                        width: 0,
                      )),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                  ),
                
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <ChartSeries<StepBarChartModel, String>>[
                    StackedColumnSeries<StepBarChartModel, String>(
                        dataSource: sdata,
                        xValueMapper: (StepBarChartModel sales, _) => sales.step_date,
                        yValueMapper: (StepBarChartModel sales1, _) =>
                            sales1.steps,
                        name: 'Record',
                        width: 0.05,
                        spacing: 0.1,
                        emptyPointSettings: EmptyPointSettings(
                            // Mode of empty point
                            mode: EmptyPointMode.average),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false)),
                  ]),
            )
          ],
            ),
          ),
        ),
      ),
    );
  }
}
