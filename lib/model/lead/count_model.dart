class CountModel {
  int? total;
  int? countModelNew;
  int? today;
  int? tomorrow;
  int? upcoming;
  int? pending;
  int? history;
  int? unassigned;

  CountModel({
    this.total,
    this.countModelNew,
    this.today,
    this.tomorrow,
    this.upcoming,
    this.pending,
    this.history,
    this.unassigned,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        total: json["TOTAL"],
        countModelNew: json["NEW"],
        today: json["TODAY"],
        tomorrow: json["TOMORROW"],
        upcoming: json["UPCOMING"],
        pending: json["PENDING"],
        history: json["HISTORY"],
        unassigned: json["UNASSIGNED"],
      );

  Map<String, dynamic> toJson() => {
        "TOTAL": total,
        "NEW": countModelNew,
        "TODAY": today,
        "TOMORROW": tomorrow,
        "UPCOMING": upcoming,
        "PENDING": pending,
        "HISTORY": history,
        "UNASSIGNED": unassigned,
      };
}
