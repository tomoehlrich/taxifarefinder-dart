// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tff_fare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TffFare _$TffFareFromJson(Map<String, dynamic> json) {
  return TffFare(
    status: json['status'] as String,
    distance: (json['distance'] as num)?.toDouble(),
    duration: (json['duration'] as num)?.toDouble(),
    totalFare: (json['total_fare'] as num)?.toDouble(),
    initialFare: TffFare._stringToDouble(json['initial_fare'] as String),
    meteredFare: (json['metered_fare'] as num)?.toDouble(),
    tipAmount: (json['tip_amount'] as num)?.toDouble(),
    tipPercentage: (json['tip_percentage'] as num)?.toDouble(),
    locale: json['locale'] as String,
    currency: json['currency'] == null
        ? null
        : _TffCurrency.fromJson(json['currency'] as Map<String, dynamic>),
    rateArea: json['rate_area'] as String,
    flatRates: (json['flat_rates'] as List)
        ?.map((e) =>
            e == null ? null : TffFlatRate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extraCharges: (json['extra_charges'] as List)
        ?.map((e) => e == null
            ? null
            : TffExtraCharge.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

TffFlatRate _$TffFlatRateFromJson(Map<String, dynamic> json) {
  return TffFlatRate(
    charge: TffFlatRate._stringToDouble(json['charge'] as String),
    description: json['description'] as String,
  );
}

TffExtraCharge _$TffExtraChargeFromJson(Map<String, dynamic> json) {
  return TffExtraCharge(
    charge: TffExtraCharge._stringToDouble(json['charge'] as String),
    description: json['description'] as String,
  );
}

_TffCurrency _$_TffCurrencyFromJson(Map<String, dynamic> json) {
  return _TffCurrency(
    intSymbol: json['int_symbol'] as String,
  );
}
