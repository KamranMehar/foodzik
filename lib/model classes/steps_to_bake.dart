class StepsToBake {
  String? title;
  String? details;

  StepsToBake({this.title, this.details});

  factory StepsToBake.fromJson(Map<String, dynamic> json) {
    if (json == null) return StepsToBake(); // Return an empty instance if json is null
    return StepsToBake(
      title: json['title'],
      details: json['details'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'details': details,
    };
  }
}
