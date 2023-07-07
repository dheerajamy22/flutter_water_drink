import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_tracker/pages/water_bar_charts/waterbarChartModel.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  List<WaterBarChartModel> data = [];
  List<WaterBarChartModel> sdata = [];
  bool wm=true;

  void dataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> getList = pref.getStringList('salesList') ?? [];
    print('object  ' + getList.toString());

    setState(() {
      sdata = getList
          .map((jsonString) => WaterBarChartModel.fromJson(jsonDecode(jsonString)))
          .toList();
    });

    print('object w ' + sdata.toString());
  }

  @override
  void initState() {
    dataList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataList();
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
                  "History",
                  style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Open_sans"),
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: SingleChildScrollView(
                child: Column(children: [
                   SizedBox(height: 30,),
                  Container(
            height: 40,
            width: 300,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        wm=true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                        decoration:  BoxDecoration( color: wm==true?Colors.blue:Colors.grey,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                        ),
                        child: Text(
                          "weekly",
                          style: TextStyle(color: wm == true?Colors.white:Colors.black,fontSize: 16, fontFamily: "Open_sans" ),
                        )),
                  ),
                ),
                Flexible(
                    child: InkWell(
                      onTap: () {
                       setState(() {
                          wm=false;
                       });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                        color: wm==false?Colors.blue:Colors.grey,
                        ),
                          child:  Text(
                                          "monthly",
                                          style: TextStyle(color: wm == false?Colors.white:Colors.black,fontSize: 16,fontFamily: "Open_sans"),
                                        )),
                    ))
              ],
            ),
          ),
                  const SizedBox(
                    height: 50,
                  ),
                  //Initialize the chart widget
                  SfCartesianChart(
                      //primaryXAxis: CategoryAxis(),
                      enableAxisAnimation: true,
                      // Chart title
                      title: ChartTitle(text: ''),
                      // Enable legend
                      legend: Legend(isVisible: false),
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(fontSize: 20),
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
                      series: <ChartSeries<WaterBarChartModel, String>>[
                        StackedColumnSeries<WaterBarChartModel, String>(
                            dataSource: sdata,
                            xValueMapper: (WaterBarChartModel sales, _) => sales.days,
                            yValueMapper: (WaterBarChartModel sales1, _) =>
                                sales1.water_quantity,
                            name: 'Record',
                            width: 0.1,
                            spacing: 0.1,
                            emptyPointSettings: EmptyPointSettings(
                                // Mode of empty point
                                mode: EmptyPointMode.average),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true)),
                      ]),
                ]),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
