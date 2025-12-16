import 'package:overseas_front_end/model/product/discount_model.dart';
import 'package:overseas_front_end/model/product/product_provider_deatils_model.dart';

import 'price_distribution_model.dart';

class ProductModel {
  String? id;
  String? productId;
  String? name;
  String? code;
  String? category;
  String? subCategory;
  bool? requiresAgreement;
  bool? supportAvailable;
  ProductProviderDeatilsModel? providerDetails;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  double? advanceRequiredPercent;
  String? ageLimit;
  double? basePrice;
  String? bhk;
  String? brand;
  String? city;
  double? costPrice;
  String? country;
  // String? countryOfStudy;
  String? courseDuration;
  String? courseLevel;
  String? description;
  List<DocumentsRequired>? documentsRequired;
  String? duration;
  List<String>? exclusions;
  String? experienceRequired;
  String? fuelType;
  String? furnishingStatus;
  List<String>? images;
  List<String>? inclusions;
  String? institutionName;
  String? insuranceValidTill;
  bool? interviewPreparation;
  bool? isRefundable;
  bool? jobAssistance;
  String? kmsDriven;
  String? location;
  String? minIncomeRequired;
  String? model;
  String? notes;
  String? possessionTime;
  List<PriceDistributionModel>? priceComponents;
  String? processingTime;
  String? propertyType;
  String? qualificationRequired;
  String? refundPolicy;
  String? registrationYear;
  double? sellingPrice;
  String? serviceMode;
  String? shortDescription;
  String? size;
  String? state;
  List<String>? stepList;
  String? supportDuration;
  List<String>? tags;
  String? termsAndConditions;
  String? transmission;
  String? travelType;
  String? validity;
  String? visaType;
  String? warrantyInfo;
  List<DiscountModel>? discounts;
  double? downpayment;
  double? loanEligibility;

  ProductModel({
    this.id,
    this.productId,
    this.name,
    this.code,
    this.category,
    this.subCategory,
    this.requiresAgreement,
    this.supportAvailable,
    this.providerDetails,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.advanceRequiredPercent,
    this.ageLimit,
    this.basePrice,
    this.bhk,
    this.brand,
    this.city,
    this.costPrice,
    this.country,
    // this.countryOfStudy,
    this.courseDuration,
    this.courseLevel,
    this.description,
    this.documentsRequired,
    this.duration,
    this.exclusions,
    this.experienceRequired,
    this.fuelType,
    this.furnishingStatus,
    this.images,
    this.inclusions,
    this.institutionName,
    this.insuranceValidTill,
    this.interviewPreparation,
    this.isRefundable,
    this.jobAssistance,
    this.kmsDriven,
    this.location,
    this.minIncomeRequired,
    this.model,
    this.notes,
    this.possessionTime,
    this.priceComponents,
    this.processingTime,
    this.propertyType,
    this.qualificationRequired,
    this.refundPolicy,
    this.registrationYear,
    this.sellingPrice,
    this.serviceMode,
    this.shortDescription,
    this.size,
    this.state,
    this.stepList,
    this.supportDuration,
    this.tags,
    this.termsAndConditions,
    this.transmission,
    this.travelType,
    this.validity,
    this.visaType,
    this.warrantyInfo,
    this.discounts,
    this.downpayment,
    this.loanEligibility,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        productId: json["product_id"],
        name: json["name"],
        code: json["code"],
        category: json["category"],
        subCategory: json["subCategory"],
        requiresAgreement: json["requiresAgreement"],
        supportAvailable: json["supportAvailable"],
        providerDetails: json["providerDetails"] == null
            ? null
            : ProductProviderDeatilsModel.fromJson(json["providerDetails"]),
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        advanceRequiredPercent: json["advanceRequiredPercent"],
        ageLimit: json["ageLimit"],
        basePrice: json["basePrice"],
        bhk: json["bhk"],
        brand: json["brand"],
        city: json["city"],
        costPrice: json["costPrice"],
        country: json["country"],
        // countryOfStudy: json["countryOfStudy"],
        courseDuration: json["courseDuration"],
        courseLevel: json["courseLevel"],
        description: json["description"],
        documentsRequired: json["documentsRequired"] == null
            ? []
            : List<DocumentsRequired>.from(json["documentsRequired"]!
                .map((x) => DocumentsRequired.fromJson(x))),
        duration: json["duration"],
        exclusions: json["exclusions"] == null
            ? []
            : List<String>.from(json["exclusions"]!.map((x) => x)),
        experienceRequired: json["experienceRequired"],
        fuelType: json["fuelType"],
        furnishingStatus: json["furnishingStatus"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        inclusions: json["inclusions"] == null
            ? []
            : List<String>.from(json["inclusions"]!.map((x) => x)),
        institutionName: json["institutionName"],
        insuranceValidTill: json["insuranceValidTill"],
        interviewPreparation: json["interviewPreparation"],
        isRefundable: json["isRefundable"],
        jobAssistance: json["jobAssistance"],
        kmsDriven: json["kmsDriven"],
        location: json["location"],
        minIncomeRequired: json["minIncomeRequired"],
        model: json["model"],
        notes: json["notes"],
        possessionTime: json["possessionTime"],
        priceComponents: json["priceComponents"] == null
            ? []
            : List<PriceDistributionModel>.from(json["priceComponents"]!
                .map((x) => PriceDistributionModel.fromJson(x))),
        processingTime: json["processingTime"],
        propertyType: json["propertyType"],
        qualificationRequired: json["qualificationRequired"],
        refundPolicy: json["refundPolicy"],
        registrationYear: json["registrationYear"],
        sellingPrice: json["sellingPrice"],
        serviceMode: json["serviceMode"],
        shortDescription: json["shortDescription"],
        size: json["size"],
        state: json["state"],
        stepList: json["stepList"] == null
            ? []
            : List<String>.from(json["stepList"]!.map((x) => x)),
        supportDuration: json["supportDuration"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        termsAndConditions: json["termsAndConditions"],
        transmission: json["transmission"],
        travelType: json["travelType"],
        validity: json["validity"],
        visaType: json["visaType"],
        warrantyInfo: json["warrantyInfo"],
        downpayment: json["downpayment"],
        loanEligibility: json["loanEligibility"],
        discounts: json["discounts"] == null
            ? []
            : List<DiscountModel>.from(
                json["discounts"]!.map((x) => DiscountModel.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        // "product_id": productId,
        "name": name,
        "code": code,
        "category": category,
        "subCategory": subCategory,
        "requiresAgreement": requiresAgreement,
        "supportAvailable": supportAvailable,
        "providerDetails": providerDetails?.toJson(),
        "status": status,
        "advanceRequiredPercent": advanceRequiredPercent,
        "ageLimit": ageLimit,
        "basePrice": basePrice,
        "bhk": bhk,
        "brand": brand,
        "city": city,
        "costPrice": costPrice,
        "country": country,
        // "countryOfStudy": countryOfStudy,
        "courseDuration": courseDuration,
        "courseLevel": courseLevel,
        "description": description,
        "documentsRequired": documentsRequired == null
            ? []
            : List<dynamic>.from(documentsRequired!.map((x) => x.toJson())),
        "duration": duration,
        "exclusions": exclusions == null
            ? []
            : List<dynamic>.from(exclusions!.map((x) => x)),
        "experienceRequired": experienceRequired,
        "fuelType": fuelType,
        "furnishingStatus": furnishingStatus,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "inclusions": inclusions == null
            ? []
            : List<dynamic>.from(inclusions!.map((x) => x)),
        "institutionName": institutionName,
        "insuranceValidTill": insuranceValidTill,
        "interviewPreparation": interviewPreparation,
        "isRefundable": isRefundable,
        "jobAssistance": jobAssistance,
        "kmsDriven": kmsDriven,
        "location": location,
        "minIncomeRequired": minIncomeRequired,
        "model": model,
        "notes": notes,
        "possessionTime": possessionTime,
        "priceComponents": priceComponents == null
            ? []
            : List<dynamic>.from(priceComponents!.map((x) => x.toJson())),
        "processingTime": processingTime,
        "propertyType": propertyType,
        "qualificationRequired": qualificationRequired,
        "refundPolicy": refundPolicy,
        "registrationYear": registrationYear,
        "sellingPrice": sellingPrice,
        "serviceMode": serviceMode,
        "shortDescription": shortDescription,
        "size": size,
        "state": state,
        "stepList":
            stepList == null ? [] : List<dynamic>.from(stepList!.map((x) => x)),
        "supportDuration": supportDuration,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "termsAndConditions": termsAndConditions,
        "transmission": transmission,
        "travelType": travelType,
        "validity": validity,
        "visaType": visaType,
        "warrantyInfo": warrantyInfo,
        "downpayment": downpayment,
        "loanEligibility": loanEligibility,
        // "discounts": discounts == null
        //     ? []
        //     : List<dynamic>.from(discounts!.map((x) => x)),
      };
}

class DocumentsRequired {
  String? docName;
  bool? mandatory;

  DocumentsRequired({
    this.docName,
    this.mandatory,
  });

  factory DocumentsRequired.fromJson(Map<String, dynamic> json) =>
      DocumentsRequired(
        docName: json["docName"],
        mandatory: json["mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "docName": docName,
        "mandatory": mandatory,
      };
}
