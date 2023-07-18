class WeekStepBarChartModel{
  final String days;
  final int steps;
  final String step_date;

  WeekStepBarChartModel({required this.days, required this.steps,required this.step_date});

  factory WeekStepBarChartModel.fromJson(Map<String, dynamic> json) {
    return WeekStepBarChartModel(days: json['days'] , steps: json['Steps'] ,
    step_date: json['wtr_date'] );
  }

  // method
  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'Steps': steps,
       'wtr_date': step_date,
    };
  }
}