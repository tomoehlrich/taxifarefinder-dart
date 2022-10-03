// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tff_taxi_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TffTaxiCompanyList _$TffTaxiCompanyListFromJson(Map<String, dynamic> json) =>
    TffTaxiCompanyList(
      json['status'] as String,
      (json['businesses'] as List<dynamic>?)
          ?.map((e) => TffTaxiCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TffTaxiCompany _$TffTaxiCompanyFromJson(Map<String, dynamic> json) =>
    TffTaxiCompany(
      json['name'] as String,
      json['phone'] as String,
      json['type'] as String,
    );
