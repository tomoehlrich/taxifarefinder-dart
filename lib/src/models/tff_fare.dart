import 'package:json_annotation/json_annotation.dart';

part 'tff_fare.g.dart';

@JsonSerializable(createToJson: false)
class TffFare {
  final String status;

  /// The trip's distance in meters
  @JsonKey(defaultValue: 0.0)
  final double distance;

  /// The trip's duration in seconds
  @JsonKey(defaultValue: 0.0)
  final double duration;

  /// The total fare in the local currency (see [currencySymbol])
  /// Includes [intialFare], [meteredFare] and [tipAmount]
  @JsonKey(name: 'total_fare', defaultValue: 0.0)
  final double totalFare;

  /// The charge for the first portion of the trip
  @JsonKey(name: 'initial_fare', fromJson: _stringToDouble, defaultValue: 0.0)
  final double initialFare;

  /// The charge based on the distance of the trip and in addition
  /// to the [initialFare]
  @JsonKey(name: 'metered_fare', defaultValue: 0.0)
  final double meteredFare;

  /// The suggested tip amount
  @JsonKey(name: 'tip_amount', defaultValue: 0.0)
  final double tipAmount;

  /// The suggested tip percentage
  @JsonKey(name: 'tip_percentage', fromJson: _stringToDouble, defaultValue: 0.0)
  final double tipPercentage;

  /// The locale of the city / entity used in the fare calculation,
  /// for example en_US
  @JsonKey(defaultValue: 'en_US')
  final String locale;

  final _TffCurrency? currency;

  /// The name of the area used for the calculation of the trip.
  /// Can differ from the city / entity optionally passed to this
  /// method.
  @JsonKey(name: 'rate_area', defaultValue: '')
  final String rateArea;

  /// A list of flat rates applied to the trip
  @JsonKey(name: 'flat_rates', defaultValue: [])
  final List<TffFlatRate> flatRates;

  /// A list of extra charges applied to the trip
  @JsonKey(name: 'extra_charges', defaultValue: [])
  final List<TffExtraCharge> extraCharges;

  TffFare({
    required this.status,
    required this.distance,
    required this.duration,
    required this.totalFare,
    required this.initialFare,
    required this.meteredFare,
    required this.tipAmount,
    required this.tipPercentage,
    required this.locale,
    required this.currency,
    required this.rateArea,
    required this.flatRates,
    required this.extraCharges,
  });

  factory TffFare.fromJson(Map<String, dynamic> json) =>
      _$TffFareFromJson(json);

  static double _stringToDouble(String number) => double.parse(number);

  /// The total fare in the local currency (see [currencySymbol])
  /// without the tip.
  /// Includes [intialFare], [meteredFare] but excludes [tipAmount]
  double get totalFareWithoutTip {
    return totalFare - tipAmount;
  }

  /// The currency code (ISO 4217) used to calculate the trip fare
  String? get currencySymbol {
    return currency?.intSymbol;
  }
}

@JsonSerializable(createToJson: false)
class TffFlatRate {
  /// The amount of the flat rate charge
  @JsonKey(fromJson: _stringToDouble)
  final double? charge;

  /// The description of the flat rate charge
  final String? description;

  TffFlatRate({
    this.charge,
    this.description,
  });

  factory TffFlatRate.fromJson(Map<String, dynamic> json) =>
      _$TffFlatRateFromJson(json);

  static double _stringToDouble(String number) => double.parse(number);
}

@JsonSerializable(createToJson: false)
class TffExtraCharge {
  /// The amount of the extra charge
  @JsonKey(fromJson: _stringToDouble)
  final double? charge;

  /// The description of the extra charge
  final String? description;

  TffExtraCharge({
    this.charge,
    this.description,
  });

  factory TffExtraCharge.fromJson(Map<String, dynamic> json) =>
      _$TffExtraChargeFromJson(json);

  static double _stringToDouble(String number) => double.parse(number);
}

@JsonSerializable(createToJson: false)
class _TffCurrency {
  @JsonKey(name: 'int_symbol')
  final String intSymbol;

  _TffCurrency({
    required this.intSymbol,
  });

  factory _TffCurrency.fromJson(Map<String, dynamic> json) =>
      _$TffCurrencyFromJson(json);
}
