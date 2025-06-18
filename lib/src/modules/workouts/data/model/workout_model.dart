class WorkoutModel {
  final String title;
  final String days;
  final String count;

  WorkoutModel({
    required this.title,
    required this.days,
    required this.count,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      title: json['title'],
      days: json['days'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'days': days,
      'count': count,
    };
  }
}
