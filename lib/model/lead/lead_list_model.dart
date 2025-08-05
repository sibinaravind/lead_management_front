import 'lead_model.dart';

class LeadListModel {
  List<LeadModel>? leads;
  int? limit;
  int? page;
  int? totalMatch;
  int? totalPages;

  LeadListModel({
    this.leads,
    this.limit,
    this.page,
    this.totalMatch,
    this.totalPages,
  });

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
        leads: List<LeadModel>.from(
            json["leads"].map((x) => LeadModel.fromJson(x))),
        limit: json["limit"],
        page: json["page"],
        totalMatch: json["totalMatch"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "leads": List<LeadModel>.from(
          leads?.map((x) => x.toJson()) ?? [],
        ),
        "limit": limit,
        "page": page,
        "totalMatch": totalMatch,
        "totalPages": totalPages,
      };
}
