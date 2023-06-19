import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_tracker/pages/bar_charts/barChartModel.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  List<BarChartModel> data = [];
  List<BarChartModel> sdata = [];

  void dataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> getList = pref.getStringList('salesList') ?? [];
    print('object  ' + getList.toString());

    setState(() {
      sdata = getList
          .map((jsonString) => BarChartModel.fromJson(jsonDecode(jsonString)))
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
                "History",
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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 60,right: 60),
                child: Container(
                  height: 40,
                  width: 300,
                  decoration:  BoxDecoration(
                      color: Color.fromARGB(255, 228, 228, 228),
                      borderRadius: BorderRadius.circular(8)
                      ),
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: (){
                             
                            },
                            child: Container(
                              decoration: BoxDecoration(
                               
                              ),
                              child: Text("weekly",style: TextStyle(fontSize: 18),)),
                          ),
                        ),
                        Flexible(child: Container(child: Text("monthly",style: TextStyle(fontSize: 18),)))
                      ],
                    ),
                  ),
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
                  series: <ChartSeries<BarChartModel, String>>[
                    StackedColumnSeries<BarChartModel, String>(
                        dataSource: sdata,
                        xValueMapper: (BarChartModel sales, _) => sales.days,
                        yValueMapper: (BarChartModel sales1, _) =>
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

              // InkWell(
              //   child: Container(
              //     height: 52,
              //     margin: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10), color: Colors.purple),
              //   ),
              //   onTap: () async {
              //     SharedPreferences pref = await SharedPreferences.getInstance();
              //     List<String> getList = pref.getStringList('salesList') ?? [];
              //     print('objectgjhkl; ' + getList.toString());
              //     setState(() {
              //       sdata = getList
              //           .map((jsonString) =>
              //               BarChartModel.fromJson(jsonDecode(jsonString)))
              //           .toList();
              //     });
              //     setState(() {
              //       int a = sdata.length - 1;
              //       //sdata.add(_SalesData(year: sdata[a].year, sales: sdata[a].sales));
              //       int c = 50 + sdata[a].water_quantity;

              //       sdata.setAll(a, [
              //         BarChartModel(
              //             days: sdata[a].days, water_quantity: c, wtr_date: 'date')
              //       ]);
              //       List<String> jsonList = sdata
              //           .map((sales_list) => jsonEncode(sales_list.toJson()))
              //           .toList();
              //       pref.setStringList('salesList', jsonList);
              //       pref.commit();
              //       print('hbb ' + sdata.toString());
              //     });
              //   },
              // )
            ]),
          ),
        ),
      ],
    ));
  }
}
