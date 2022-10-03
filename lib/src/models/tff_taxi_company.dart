import 'package:json_annotation/json_annotation.dart';

part 'tff_taxi_company.g.dart';

@JsonSerializable(createToJson: false)
class TffTaxiCompanyList {
  final String status;

  final List<TffTaxiCompany>? businesses;

  TffTaxiCompanyList(this.status, this.businesses);

  factory TffTaxiCompanyList.fromJson(Map<String, dynamic> json) =>
      _$TffTaxiCompanyListFromJson(json);
}

@JsonSerializable(createToJson: false)
class TffTaxiCompany {
  /// The name of the taxi company
  final String name;

  /// The phone number of the taxi company
  final String phone;

  /// The type of the taxi company.
  /// Can be taxi or limo
  final String type;

  TffTaxiCompany(this.name, this.phone, this.type);

  factory TffTaxiCompany.fromJson(Map<String, dynamic> json) =>
      _$TffTaxiCompanyFromJson(json);
}
