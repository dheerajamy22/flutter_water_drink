class WeekWaterBarChartModel{
  final String days;
  final int water_quantity;
  final String wtr_date;

  WeekWaterBarChartModel({required this.days, required this.water_quantity,required this.wtr_date});

  factory WeekWaterBarChartModel.fromJson(Map<String, dynamic> json) {
    return WeekWaterBarChartModel(days: json['days'] , water_quantity: json['water_quantity'] ,
    wtr_date: json['wtr_date'] );
  }

  // method
  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'water_quantity': water_quantity,
       'wtr_date': wtr_date,
    };
  }
}