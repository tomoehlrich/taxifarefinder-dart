// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tff_taxi_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TffTaxiCompanyList _$TffTaxiCompanyListFromJson(Map<String, dynamic> json) {
  return TffTaxiCompanyList(
      json['status'] as String,
      (json['businesses'] as List)
          ?.map((e) => e == null
              ? null
              : TffTaxiCompany.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

TffTaxiCompany _$TffTaxiCompanyFromJson(Map<String, dynamic> json) {
  return TffTaxiCompany(
      json['name'] as String, json['phone'] as String, json['type'] as String);
}
